//
//  URLSessionHTTPClient.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

public class URLSessionHTTPClient : HTTPClient {
    private let session : URLSession
    
    public init(session : URLSession = .shared) {
        self.session = session
    }
    
    private struct UnExpectedValuesRepresentation : Error {}
    
    public func get(from url : URL, completion : @escaping (HTTPClientResult) -> Void) {
        self.session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnExpectedValuesRepresentation()))
            }
        }).resume()
    }
}
