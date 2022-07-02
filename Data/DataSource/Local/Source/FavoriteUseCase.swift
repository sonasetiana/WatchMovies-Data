//
//  FavoriteUseCase.swift
//  Domain
//
//  Created by sona setiana on 02/07/22.
//

import Foundation
import Data

protocol FavoriteUseCase {
    func getListFavorite(completion: @escaping (Result<[MovieTable], Error>) -> Void)
    func removeFavorite(id: Int, completion: @escaping (Result<String, Error>) -> Void)
}

class FavoriteInteractor : FavoriteUseCase {
    let repository : MovieRepository
    
    init(repository : MovieRepository) {
        self.repository = repository
    }
    
    func getListFavorite(completion: @escaping (Result<[MovieTable], Error>) -> Void) {
        repository.getListFavorite(completion: completion)
    }
    
    func removeFavorite(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        repository.deleteFavorite(movieId: id, completion: completion)
    }
}
