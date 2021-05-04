//
//  ImagePosterBuilder.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

final class ImagePosterBuilder {
    
    static let instance = ImagePosterBuilder()
    
    static func fullPosterPath(posterPath: String, posterSize: String) -> URL? {
        guard let basePath = URL(string: Config.URL.basePoster) else { return nil }
        let fullPosterPath = basePath.appendingPathComponent(posterSize)
            .appendingPathComponent(posterPath)
        return fullPosterPath
    }
}

typealias PosterSize = String

struct PosterSizes {
    static let w92 = "w92"
    static let w154 = "w154"
    static let w185 = "w185"
    static let w342 = "w342"
    static let w500 = "w500"
    static let w780 = "w780"
}
