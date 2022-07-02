//
//  ModelUtils.swift
//  Data
//
//  Created by sona setiana on 02/07/22.
//

import Foundation

public func convertGenresToString(items: [MovieGenreEntity]) -> String {
    if items.isEmpty {
        return ""
    }
    let genre = items.compactMap{$0.name}.joined(separator: ", ")
    return genre
}

public func convertCountryToString(items: [MovieCountryEntity]) -> String {
    if items.isEmpty {
        return ""
    }
    let genre = items.compactMap{$0.name}.joined(separator: ", ")
    return genre
}

public func convertCompanyToString(items: [MovieCompanieEntity]) -> String {
    if items.isEmpty {
        return ""
    }
    let genre = items.compactMap{$0.name}.joined(separator: ", ")
    return genre
}

public func convertSpokenLanguageToString(items: [MovieSpokenLanguageEntity]) -> String {
    if items.isEmpty {
        return ""
    }
    let genre = items.compactMap{$0.english_name}.joined(separator: ", ")
    return genre
}

public enum ImageSize: String {
    case original
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
}

public func getImageMovie(imagePath: String, imageSize: ImageSize) -> String{
    let link = "\(ApiConfigs.IMAGE_URL)\(imageSize.rawValue)/\(imagePath)"
    print(link)
    return link
}
