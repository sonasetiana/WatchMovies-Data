//
//  DetailUseCase.swift
//  Domain
//
//  Created by sona setiana on 02/07/22.
//

import Foundation
import Data

protocol DetailUseCase {
    func getDetailMovie(movieId: Int, completion: @escaping (Result<MovieDetailEntity, Error>) -> Void)
    func saveMovieToFavorite(movie: MovieDetailEntity, completion: @escaping (Result<String, Error>) -> Void)
    func removeMovieFromFavorite(id: Int, completion: @escaping (Result<String, Error>) -> Void)
    func findFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

class DetailInteractor : DetailUseCase {
    let repository : MovieRepository

    init(repository : MovieRepository) {
        self.repository = repository
    }
    
    func getDetailMovie(movieId: Int, completion: @escaping (Result<MovieDetailEntity, Error>) -> Void) {
        repository.getDetailMovie(movieId: movieId, completion: completion)
    }
    
    func saveMovieToFavorite(movie: MovieDetailEntity, completion: @escaping (Result<String, Error>) -> Void) {
        repository.saveFavorite(movie: movie, completion: completion)
    }
    
    func removeMovieFromFavorite(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        repository.deleteFavorite(movieId: id, completion: completion)
    }
    
    func findFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.findFavorite(id: id, completion: completion)
    }
}
