//
//  MovieCell.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import UIKit
import SDWebImage
import RxRelay
import RxSwift

//
// MARK: - Movie Cell
//
class MovieCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    var vwModel: BehaviorRelay<NowPLayingMovieCellViewModel?> = BehaviorRelay(value: nil)
    
    private let disposeBag = DisposeBag()
    
    //MARK: LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.bindVwModel()
    }
    
    //MARK: Helpers
    
    private func bindVwModel() {
        vwModel.bind { (value) in
            guard let val = value else { return }
            self.title.text = val.title
            self.releaseDate.text = val.releaseDate
            if let fullPosterPath = val.fullPosterPath(with: PosterSizes.w92) {
                self.poster.sd_setImage(with: fullPosterPath, placeholderImage: nil, options: .retryFailed, context: nil)
            }
        }.disposed(by: disposeBag)
    }
}
