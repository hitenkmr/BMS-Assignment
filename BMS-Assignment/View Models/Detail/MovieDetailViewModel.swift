//
//  MovieDetailViewModel.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailViewModel: BaseViewModel {
    
    let detail = PublishSubject<MovieDataDetailViewModel>()
    
    init(id: Int) {
        super.init()
        
        self.getDetails(id: id)
    }
}

extension MovieDetailViewModel {
    
    func getDetails(id: Int) {
        guard let url = URL(string: TheMovieDBEndPoint.getMovieDetails(movieId: id).path) else { return }
        
        self.movieLoader.loadMovieDetail(url: url) { [weak self] (result) in
            guard let weak_self = self else { return }
            switch result {
            case .success(let movie):
                let detailDataVM = MovieDataDetailViewModel(movie: movie)
                weak_self.detail.onNext(detailDataVM)
            case let.failure(error):
                weak_self.onError.onNext(error.localizedDescription)
            }
        }
    }
}
