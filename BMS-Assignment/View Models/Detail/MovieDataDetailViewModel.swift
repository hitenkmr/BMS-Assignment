//
//  MovieDataDetailViewModel.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

class MovieDataDetailViewModel: MovieBaseViewModel, MovieSharedData {
    
    override init(movie: Movie) {
        super.init(movie: movie)
    }
    
    var title: String? {
        self.movie.title
    }
    
    var releaseDate: String? {
        self.movie.releaseDate
    }
    
    var overview: String? {
        self.movie.overview
    }
    
    private var genres: [MovieGenre] {
        self.movie.genres ?? []
    }
    
    var genresNames: [String] {
        self.genres.compactMap({ $0.name?.uppercased() })
    }
    
    var serverFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.yyyy_MM_dd
        return formatter
    }
    
    var formattedReleaseDate: String? {
        let formatter = serverFormatter
        
        guard let releaseDateString = releaseDate, let date = formatter.date(from: releaseDateString) else { return nil }
        formatter.dateFormat = DateFormats.MMMM_d_yyyy
        return formatter.string(from: date)
    }
}

