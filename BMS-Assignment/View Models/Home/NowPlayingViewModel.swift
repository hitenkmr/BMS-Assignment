//
//  NowPlayingViewModel.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation
import RxSwift

class NowPlayingViewModel: BaseViewModel {
    
    private var movies = [Movie]()
    
    var viewModels: [NowPLayingMovieCellViewModel] {
        return movies.map({ NowPLayingMovieCellViewModel(movie: $0) })
    }
    
    //MARK: INIT
    
    override init() {
        super.init()
        self.loadMovies()
    }
}

extension NowPlayingViewModel {
    
    func loadMovies() {
        movieLoader.loadMovies(url: URL(string: TheMovieDBEndPoint.getNowPlayingMovies.path)!) { [weak self] (result) in
            guard let weak_self = self else { return }
            switch result {
            case .success(let movies):
                weak_self.movies = movies
                weak_self.dataRefreshed.onNext(true)
            case let.failure(error):
                weak_self.onError.onNext(error.localizedDescription)
            }
        }
    }
}
