//
//  MovieCompanieEntity.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import Foundation

public struct MovieCompanieEntity : Decodable {
    public var id: Int?
    public var name: String?
    public var logo_path: String?
    public var origin_country: String?
}
