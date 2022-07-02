//
//  DomainModules.swift
//  Domain
//
//  Created by sona setiana on 02/07/22.
//

import Foundation
import Data

class DomainModules {
    static let shared = DomainModules()
    
    func provideHomeUseCase() -> HomeUseCase {
        let repository = DataModules.shared.provideMovieRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetailUseCase() -> DetailUseCase {
        let repository = DataModules.shared.provideMovieRepository()
        return DetailInteractor(repository: repository)
    }
    
    func provideFavoriteUseCase() -> FavoriteUseCase {
        let repository = DataModules.shared.provideMovieRepository()
        return FavoriteInteractor(repository: repository)
    }
}
