//
//  MovieLoader.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

public enum LoadMovieResult {
    case success([Movie])
    case failure(Error)
}

public enum LoadMovieDetailResult {
    case success(Movie)
    case failure(Error)
}

public protocol MovieLoader {
    func loadMovies(url: URL, completion : @escaping (LoadMovieResult) -> Void)
    func loadMovieDetail(url: URL, completion : @escaping (LoadMovieDetailResult) -> Void)
}
 
