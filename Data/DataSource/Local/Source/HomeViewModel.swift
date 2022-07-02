//
//  HomeViewModel.swift
//  Presentation
//
//  Created by sona setiana on 02/07/22.
//

import Foundation
import Combine
import Domain
import Data

class HomeViewModel : ObservableObject {
    let useCase : HomeUseCase
    
    @Published var movies : [MovieEntity] = []
    @Published var errorMsg : String = ""
    @Published var loading : Bool = false
    
    var subscription: Set<AnyCancellable> = []
    @Published var keyword : String = "" {
        didSet {
            initSearchField()
        }
    }

    init(useCase : HomeUseCase) {
        self.useCase = useCase
    }
    
    private func initSearchField() {
        $keyword
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { (text) -> String? in
                return text
            }
            .compactMap { $0 }
            .sink(receiveValue: { [self] (text) in
                if text.isEmpty {
                    getListMovies()
                }else {
                    searchMovies(text: text)
                }
            })
            .store(in: &subscription)
    }
    
    func getListMovies() {
        if loading == true {
            return
        }
        loading = true
        useCase.getListMovies { results in
            switch(results){
            case .success(let movies) :
                self.movies = movies
                self.loading = false
            case .failure(let error) :
                self.errorMsg = error.localizedDescription
                self.loading = false
            }
        }
    }
    
    func searchMovies(text: String) {
        if loading == true {
            return
        }
        loading = true
        useCase.searchMovies(keyword: text) { results in
            switch(results){
            case .success(let movies) :
                self.loading = false
                self.movies = movies
            case .failure(let error) :
                self.loading = false
                self.errorMsg = error.localizedDescription
            }
        }
    }
}
