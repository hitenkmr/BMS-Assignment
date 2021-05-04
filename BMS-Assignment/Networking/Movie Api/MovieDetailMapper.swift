//
//  MovieDetailMapper.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

internal final class MovieDetailMapper {
   
    private static var OK_200 : Int { return 200 }
    
    internal static func map(data : Data, from response : HTTPURLResponse) throws -> RemoteMovieItem {
        
        guard response.statusCode == OK_200,
              let item = try? JSONDecoder().decode(RemoteMovieItem.self, from: data) else {
            throw RemoteMovieLoader.Error.invalidData
        }
        return item
    }
}
