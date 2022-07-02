//
//  MovieDetailEntity.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import Foundation
import UIKit

public struct MovieDetailEntity : Decodable {
    public var id: Int?
    public var adult : Bool?
    public var backdrop_path: String?
    public var original_language: String?
    public var original_title: String?
    public var overview: String?
    public var popularity: Double?
    public var poster_path: String?
    public var release_date: String?
    public var title: String?
    public var status: String?
    public var budget: Int?
    public var revenue: Int?
    public var genres: [MovieGenreEntity]
    public var production_companies: [MovieCompanieEntity]
    public var spoken_languages: [MovieSpokenLanguageEntity]
    public var production_countries: [MovieCountryEntity]
}
