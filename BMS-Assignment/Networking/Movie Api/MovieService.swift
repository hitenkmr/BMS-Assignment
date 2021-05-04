//
//  MovieService.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

final class MovieService {
    
    static let shared = MovieService()
    
    let loader: MovieLoader
    
    init() {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        loader = RemoteMovieLoader(client: client)
    }
}
