//
//  RemoteMovieLoader.swift
//  BMS-Assignment
//
//  Created by Hitender Kumar on 03/04/21.
//  Copyright © 2021 Hitender. All rights reserved.
//

import Foundation

public final class RemoteMovieLoader : MovieLoader {
  
    private let client : HTTPClient
    
    public enum Error : Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadMovieResult
    public typealias DetailResult = LoadMovieDetailResult

    public init(client : HTTPClient) {
        self.client = client
    }
    
    public func loadMovies(url: URL, completion : @escaping (Result) -> Void) {
        client.get(from: url, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let.success(data, response):
                completion(RemoteMovieLoader.mapMovies(data, response: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        })
    }
    
    public func loadMovieDetail(url: URL, completion: @escaping (LoadMovieDetailResult) -> Void) {
        client.get(from: url, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let.success(data, response):
                completion(RemoteMovieLoader.mapMovieDetail(data, response: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        })
    }
    
    private static func mapMovies(_ data : Data, response : HTTPURLResponse) -> Result {
        do {
            let items = try MovieItemsMapper.map(data: data, from: response)
            return .success(items.toModels())
        } catch  {
            return .failure(error)
        }
    }
    
    private static func mapMovieDetail(_ data : Data, response : HTTPURLResponse) -> DetailResult {
        do {
            let item = try MovieDetailMapper.map(data: data, from: response)
            return .success( Movie(id: item.id, posterPath: item.posterPath, releaseDate: item.releaseDate, title: item.title, voteAverage: item.voteAverage, voteCount: item.voteCount, overview: item.overview, genres: item.genres?.toGenres()))
        } catch  {
            return .failure(error)
        }
    }
}

private extension Array where Element == RemoteMovieItem {
    func toModels() -> [Movie] {
        return map({ Movie(id: $0.id, posterPath: $0.posterPath, releaseDate: $0.releaseDate, title: $0.title, voteAverage: $0.voteAverage, voteCount: $0.voteCount, overview: $0.overview, genres: $0.genres?.toGenres()) })
    }
}

private extension Array where Element == RemoteMovieGenre {
    func toGenres() -> [MovieGenre] {
        return map({ MovieGenre(id: $0.id, name: $0.name) })
    }
}
