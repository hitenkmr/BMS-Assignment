//
//  BaseTableVC.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import UIKit

class BaseTableVC: UIViewController {
    
    final func loadNextData(for scrollView: UIScrollView) -> Bool {
        let currentOffset = scrollView.contentOffset.y
        
        if scrollView.contentSize.height < scrollView.frame.size.height {
            return false
        }
        
        let maiximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maiximumOffset - currentOffset
        
        if deltaOffset <= 350 {
            return true
        }
        
        return false
    }
}
