//
//  HomeView.swift
//  Presentation
//
//  Created by sona setiana on 02/07/22.
//

import SwiftUI
import Common

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.loading {
                    LoadingView()
                } else if !viewModel.errorMsg.isEmpty {
                    ErrorView(message: viewModel.errorMsg) {
                        self.viewModel.getListMovies()
                    }
                } else {
                    if viewModel.movies.isEmpty {
                        EmptyView()
                    } else {
                        listData
                    }
                }
            }
            .searchable(text: $viewModel.keyword)
            .navigationBarTitle("WatchMovies")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AppModules.shared.provideFavoriteView()) {
                        Image(AppIcons.imgUnFavorite)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AboutView()) {
                        Image(AppIcons.imgUser)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }.onAppear(perform: {
                self.viewModel.getListMovies()
            })
        }
    }
}

extension HomeView {
    var listData : some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: AppSpacings.normal
            ){
                ForEach(viewModel.movies.indices, id: \.self) { it in
                    ItemHome(movie: viewModel.movies[it])
                }
            }.padding(.horizontal)
        }
    }
}

struct ItemHome : View {
    var movie : MovieEntity
    var body: some View {
        NavigationLink(destination: AppModules.shared.provideDetailView(movieId: movie.id)) {
            VStack {
                AsyncImage(
                    url: URL(string: getImageMovie(imagePath: movie.backdrop_path ?? "", imageSize: ImageSize.w342)), scale: 2) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: .infinity, height: 180)
                    .cornerRadius(AppSpacings.regular)
                VStack {
                    Text(movie.title ?? "")
                        .font(.system(size: 14, weight: .bold))
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, -3)
                    Text(movie.release_date ?? "")
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                }.frame(height: 97)
            }.frame(width: .infinity, height: 287.0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppModules.shared.provideHomeView()
    }
}
