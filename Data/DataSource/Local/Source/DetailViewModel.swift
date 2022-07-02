//
//  DetailViewModel.swift
//  Presentation
//
//  Created by sona setiana on 02/07/22.
//

import Foundation
import Domain
import Data
import Common

class DetailViewModel : ObservableObject {
    let movieId: Int?
    let useCase : DetailUseCase
    
    @Published var movie : MovieDetailEntity?
    @Published var errorMsg : String = ""
    @Published var loading : Bool = false
    @Published var isFavorite : Bool = false
    
    init(movieId: Int?, useCase : DetailUseCase) {
        self.movieId = movieId
        self.useCase = useCase
        getDetailMovie()
    }
    
    func getDetailMovie() {
        if movieId == nil {
            return
        }
        
        if loading == true {
            return
        }
        
        loading = true
        useCase.getDetailMovie(movieId: movieId!) { result in
            switch(result){
            case .success(let movie) :
                self.loading = false
                self.movie = movie
                self.checkIsFavorite()
            case .failure(let error) :
                self.loading = false
                self.errorMsg = error.localizedDescription
            }
        }
    }
    
    func setFavotite() {
        if isFavorite {
            removeFromFavorite()
        } else {
            saveToFavorite()
        }
    }
    
    func saveToFavorite() {
        if movie == nil {
            toast(message: "Error, cannot save to favorite")
            return
        }
        useCase.saveMovieToFavorite(movie: movie!) { result in
            switch(result) {
                case .success(let msg):
                    toast(message: msg)
                    self.checkIsFavorite()
                case .failure(let error):
                    print("Save Favorite: ", error.localizedDescription)
                    toast(message: "Failed save favorite")
            }
        }
    }
    
    func removeFromFavorite() {
        if movie == nil {
            toast(message: "Error, cannot remove from favorite")
            return
        }
        useCase.removeMovieFromFavorite(id: movie?.id ?? 0) { result in
            switch(result) {
                case .success(let msg):
                    toast(message: msg)
                    self.checkIsFavorite()
                case .failure(let error):
                    print("Remove Favorite: ", error.localizedDescription)
                    toast(message: "Success remove favorite")
            }
        }
    }
    
    func checkIsFavorite() {
        if movieId == nil {
            isFavorite = false
            return
        }
        self.useCase.findFavorite(id: movieId!) { result in
            switch(result) {
            case .success(let isFavorite):
                self.isFavorite = isFavorite
            case .failure:
                self.isFavorite = false
            }
        }
    }
}
