//
//  TokenViewAdapter.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

protocol TokenViewAdapterProtocol {
    func reload()
}

class TokenViewAdapter {
    
    //MARK: PROPERTIES
    
    let tokenView: UURCCentralizedTokenView
    
    //MARK: INIT
    
    init(parent: UIViewController, tokens: [String]) {
        self.tokenView = UURCCentralizedTokenView(tokenArray: tokens)
        self.tokenView.parentViewController = parent
        
        self.setup()
    }
}

extension TokenViewAdapter: TokenViewAdapterProtocol {
    
    //MARK: TokenViewAdapterProtocol
    
    func reload() {
        self.tokenView.reloadTokens()
    }
}

extension TokenViewAdapter {
    
    //MARK: PRIVATE HELPERS
    
    private func setup() {
        self.tokenView.selectedTokenColor = .white
        self.tokenView.selectedTokenRadius = 5
        self.tokenView.selectedTokenTitleColor = .AppLightBlackColor
        self.tokenView.selectedTokenFont = .systemFont(ofSize: 12, weight: .medium)
        
        self.tokenView.unselectedTokenColor = .white
        self.tokenView.unselectedTokenRadius = 5
        self.tokenView.unselectedTokenTitleColor = .AppLightBlackColor
        self.tokenView.unselectedTokenFont = .systemFont(ofSize: 12, weight: .medium)
    }
}
