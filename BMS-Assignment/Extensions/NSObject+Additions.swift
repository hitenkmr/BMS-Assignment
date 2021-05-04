//
//  NSObject+Additions.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className : String {
        return String(describing: self)
    }
    
    var className: String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }
}
