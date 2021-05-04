//
//  Movie.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

public struct MovieGenre: Decodable, Equatable {
    var id: Int?
    var name: String?
}

public struct Movie {
    public let id: Int?
    public let posterPath, releaseDate, title: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let overview: String?
    public let genres: [MovieGenre]?
}

extension Movie: Equatable { }

extension Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case overview = "overview"
        case genres = "genres"
    }
}
