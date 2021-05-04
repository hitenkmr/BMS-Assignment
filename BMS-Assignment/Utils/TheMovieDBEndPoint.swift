//
//  TheMovieDBEndPoint.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

enum TheMovieDBEndPoint {
    case getNowPlayingMovies
    case getMovieDetails(movieId: Int)
}

extension TheMovieDBEndPoint: Endpoint {
    var path: String {
        switch self { 
        case .getNowPlayingMovies:
            return "\(Config.URL.base)/movie/now_playing?api_key=\(Config.apiKey)&language=en-US&page=undefined"
        case let .getMovieDetails(movieId: movieId):
            return "\(Config.URL.base)/movie/\(movieId)?api_key=\(Config.apiKey)&language=en-US"
        }
    }
}
