//
//  MovieBaseViewModel.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

protocol MoviePoster {
    var posterPath: String? { get }
    
    func fullPosterPath(with posterSize: PosterSize) -> URL?
}

class MovieBaseViewModel: MoviePoster {
    
    //MARK: PROPERTIES
    
    let movie: Movie
    
    //MARK: INIT
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    //MARK: COMPUTED PROPERTIES
    
    var posterPath: String? {
        self.movie.posterPath
    }
    
    func fullPosterPath(with posterSize: PosterSize) -> URL? {
        guard let posterPath = self.posterPath else { return nil }
        return ImagePosterBuilder.fullPosterPath(posterPath: posterPath, posterSize: posterSize)
    }
}
