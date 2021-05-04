//
//  HomeVC.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import UIKit
import SDWebImage

import RxSwift
import RxCocoa

class HomeVC: BaseTableVC {
    
    //MARK: Outlets

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Private properties
 
    private lazy var refreshControl = UIRefreshControl()
    
    private let nowPlayingViewModel = NowPlayingViewModel()
    private let disposeBag = DisposeBag()

    //MARK: VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews()
        bind()
    }
}

extension HomeVC {
    
    //MARK: HELPERS
    
    private func bind() {
        self.nowPlayingViewModel.dataRefreshed
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] (refreshed) in
                guard let weak_self = self else { return }
                weak_self.nowPlayingViewModel.isPageLoading.accept(false)
                weak_self.refreshControl.endRefreshing()
                weak_self.tableView.reloadData()
            }.disposed(by: disposeBag)
        
        nowPlayingViewModel.onError
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] (message) in
                guard let weak_self = self else { return }
                print(message)
                weak_self.nowPlayingViewModel.isPageLoading.accept(false)
                weak_self.refreshControl.endRefreshing()
            }.disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged).bind {
            self.refreshControl.beginRefreshing()
             self.nowPlayingViewModel.loadMovies()
         }.disposed(by: self.disposeBag)
    }
    
    private func configureSubViews() {
        self.tableView.refreshControl = self.refreshControl
    }
    
    private func showDetailScreen(with id: Int) {
        let detilVC = MovieDetailVC(movieId: id)
        detilVC.modalPresentationStyle = .overCurrentContext
        self.present(detilVC, animated: false, completion: nil)
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.nowPlayingViewModel.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.className,
                                                           for: indexPath) as! MovieCell
        cell.vwModel.accept(self.nowPlayingViewModel.viewModels[indexPath.row])
        return cell
    }
    
    //MARK: UITableViewDelegate
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = self.nowPlayingViewModel.viewModels[indexPath.row].id else { return }
        showDetailScreen(with: id)
    }
}
