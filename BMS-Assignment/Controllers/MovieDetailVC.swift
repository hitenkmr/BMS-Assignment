//
//  MovieDetailVC.swift 
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class MovieDetailVC: UIViewController {
    
    //MARK: OUTLETS
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scrolllContentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK: Private Properties

    private var vwModel: MovieDetailViewModel!

    private var tokenAdapter: TokenViewAdapter!
    private let disposeBag = DisposeBag()
    
    //MARK: VIEW LIFE CYCLE
    
    init(movieId: Int) {
        self.vwModel = MovieDetailViewModel(id: movieId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        bind()
    }
    
    //MARK: PRIVATE HELPERS
    
    private func setupSubviews() {
        
        self.backBtn.setImage(UIImage(named: "cross")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.backBtn.tintColor = UIColor.AppLightBlackTextColor
        
        self.posterImageView.layer.borderWidth = 2.0
        self.posterImageView.layer.borderColor = UIColor.AppLightBlackColor.cgColor
        
        self.scrolllContentView.isHidden = true
        self.activityIndicator.startAnimating()
        
        view.isOpaque = false
        view.backgroundColor = UIColor.AppDarkBlackColor.withAlphaComponent(0.95)
        
        self.durationLabel.isHidden = true
    }
    
    private func bind() {
        
        self.backBtn.rx.controlEvent(.touchUpInside).bind {
            self.dismiss(animated: false, completion: nil)
        }.disposed(by: disposeBag)
        
        self.vwModel.detail
            .observe(on: MainScheduler.instance)
            .subscribe { (model) in
                self.setData(model: model)
            } .disposed(by: disposeBag)
        
        vwModel.onError
            .observe(on: MainScheduler.instance)
            .subscribe { (message) in
                print(message)
            }.disposed(by: disposeBag)
    }
    
    private func setData(model: MovieDataDetailViewModel) {
        
        self.scrolllContentView.isHidden = false
        self.activityIndicator.stopAnimating()
        
        self.posterImageView.sd_setImage(with: model.fullPosterPath(with: PosterSizes.w154), placeholderImage: nil, options: .retryFailed, context: nil)
        self.titleLabel.text = model.title
        self.releaseDateLabel.text = model.formattedReleaseDate
        self.overviewLabel.text = model.overview
        
        let tokens = model.genresNames
        
        self.setupTokenView(tokens: tokens)
    }
    
    private func setupTokenView(tokens: [String]) {
        self.tokenAdapter = TokenViewAdapter(parent: self, tokens: tokens)
        
        self.stackView.addArrangedSubview(tokenAdapter.tokenView)
        self.tokenAdapter.reload()
    }
}
