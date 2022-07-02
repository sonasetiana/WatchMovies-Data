//
//  DetailView.swift
//  Presentation
//
//  Created by sona setiana on 02/07/22.
//


import SwiftUI
import Common

struct DetailView: View {
    
    @ObservedObject var viewModel : DetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.loading {
                LoadingView()
            } else if !viewModel.errorMsg.isEmpty {
                ErrorView(message: viewModel.errorMsg) {
                    viewModel.getDetailMovie()
                }
            } else {
                if viewModel.movie == nil {
                    EmptyView()
                } else  {
                    contentData
                }
            }
        }
        .navigationTitle("Detail")
    }
}

extension DetailView {
    
    var header : some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: URL(string: getImageMovie(imagePath: viewModel.movie?.backdrop_path ?? "", imageSize: ImageSize.w500)), scale: 2) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: .infinity, height: 180.0)
            
            VStack(alignment:.leading) {
                HStack {
                    Text(viewModel.movie?.release_date ?? "")
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                    Text(viewModel.movie?.status ?? "")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.blue)
                }
                Text(viewModel.movie?.title ?? "")
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(3)
                    .padding(.vertical, -2)
                Text(convertGenresToString(items: viewModel.movie?.genres ?? []))
                    .font(.system(size: 12, weight: .light))
                    .lineLimit(2)
                HStack {
                    Spacer()
                    Button(action: {
                        self.viewModel.setFavotite()
                    }, label: {
                        Image(self.viewModel.isFavorite ? AppIcons.imgFavorite : AppIcons.imgUnFavorite)
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                }
            }.padding(
                EdgeInsets(
                    top: AppSpacings.small,
                    leading: AppSpacings.medium,
                    bottom: AppSpacings.normal,
                    trailing: AppSpacings.medium
                )
            )
        }
    }
    
    var contentData : some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                header
                Divider()
                ItemDetailView(title: "Sinopsis", value: viewModel.movie?.overview ?? "")
                ItemDetailView(title: "Perusahaan Produksi", value: convertCompanyToString(items: viewModel.movie?.production_companies ?? []))
                ItemDetailView(title: "Negara Produksi", value: convertCountryToString(items: viewModel.movie?.production_countries ?? []))
                ItemDetailView(title: "Bahasa", value: convertSpokenLanguageToString(items: viewModel.movie?.spoken_languages ?? []))
                ItemDetailView(title: "Anggaran", value: toCurrency(num: viewModel.movie?.budget ?? 0))
                ItemDetailView(title: "Pendapatan", value:toCurrency(num: viewModel.movie?.revenue ?? 0))
            }
        }
    }
}

struct ItemDetailView : View {
    var title : String
    var value : String
    var body : some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.bottom, -1)
                Text(value)
                    .font(.system(size: 12, weight: .light))
            }.padding(
                EdgeInsets(
                    top: AppSpacings.small,
                    leading: AppSpacings.medium,
                    bottom: AppSpacings.normal,
                    trailing: AppSpacings.medium
                )
            )
            Divider()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppModules.shared.provideDetailView(movieId: nil)
    }
}
