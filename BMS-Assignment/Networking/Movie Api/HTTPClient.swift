//
//  HTTPClient.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation
/**
 'HTTPClient'  protocol to provide inetrface for getting data from server with 'HTTPClientResult' in completion handler.
 
 HTTPClientResult gives Data with HTTPURLResponse on success and Error on failure
 */

public protocol HTTPClient {
    func get(from url : URL, completion : @escaping (HTTPClientResult) -> Void)
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
