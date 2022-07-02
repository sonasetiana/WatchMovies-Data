//
//  AppModules.swift
//  Presentation
//
//  Created by sona setiana on 02/07/22.
//


import Foundation
import SwiftUI
import Domain

class AppModules {
    static let shared = AppModules()
    
    func provideHomeView() -> some View {
        let useCase = DomainModules.shared.provideHomeUseCase()
        let viewModel = HomeViewModel(useCase: useCase)
        return HomeView(viewModel: viewModel)
    }
    
    func provideDetailView(movieId: Int?) -> some View {
        let useCase = DomainModules.shared.provideDetailUseCase()
        let viewModel = DetailViewModel(movieId: movieId, useCase: useCase)
        return DetailView(viewModel: viewModel)
    }
    
    func provideFavoriteView() -> some View {
        let useCase = DomainModules.shared.provideFavoriteUseCase()
        let viewModel = FavoriteViewModel(useCase: useCase)
        return FavoriteView(viewModel: viewModel)
    }
}
