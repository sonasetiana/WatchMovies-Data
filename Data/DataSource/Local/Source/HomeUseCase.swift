//
//  HomeUseCase.swift
//  Domain
//
//  Created by sona setiana on 02/07/22.
//

import Foundation
import Data

protocol HomeUseCase {
    func getListMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func searchMovies(keyword: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void)
}

class HomeInteractor : HomeUseCase {
    let repository : MovieRepository
    
    init(repository : MovieRepository) {
        self.repository = repository
    }
    
    func getListMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        repository.getListMovie(completion: completion)
    }
    
    func searchMovies(keyword: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        repository.searchMovie(keyword: keyword, completion: completion)
    }
}
