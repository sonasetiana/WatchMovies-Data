//
//  MovieEntity.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation

public struct MovieEntity : Decodable {
    public var adult : Bool?
    public var backdrop_path: String?
    public var genre_ids: [Int]?
    public var id: Int?
    public var original_language: String?
    public var original_title: String?
    public var overview: String?
    public var popularity: Double?
    public var poster_path: String?
    public var release_date: String?
    public var title: String?
    public var video: Bool?
    public var vote_average: Double?
    public var vote_count: Int
}

public struct MovieResponse : Decodable {
    public var page: Int?
    public var total_pages: Int?
    public var total_results: Int?
    public var results: [MovieEntity]
}
