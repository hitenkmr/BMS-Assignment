//
//  BaseViewModel.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

typealias InProgress = Bool
typealias IsEmptyData = Bool
typealias ErrorMessage = String

class BaseViewModel {
    
    let movieLoader = MovieService.shared.loader
    
    let isPageLoading = BehaviorRelay<Bool>(value: false)
    
    let inProgress = PublishSubject<InProgress>()
    var dataRefreshed = PublishSubject<IsEmptyData>()
    let onError = PublishSubject<ErrorMessage>()
    
    var disposeBag = DisposeBag()
}
