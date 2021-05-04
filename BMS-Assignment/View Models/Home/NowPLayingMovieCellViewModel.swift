//
//  NowPLayingMovieCellViewModel.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

protocol MovieSharedData {
    var title: String? { get }
    var releaseDate: String? { get }
}

class NowPLayingMovieCellViewModel: MovieBaseViewModel, MovieSharedData {
    
    override init(movie: Movie) {
        super.init(movie: movie)
    }
    
    //MARK: COMPUTED PROPERTIES
    
    var id: Int? {
        self.movie.id
    }
    
    var title: String? {
        self.movie.title
    }
    
    var releaseDate: String? {
        self.movie.releaseDate
    }
}
