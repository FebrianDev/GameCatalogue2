//
//  RemoteDataSource.swift
//  GameCatalogue2
//
//  Created by Febrian on 01/04/24.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getGames() -> AnyPublisher<GamesResponse, Error>
    func getGameDetail(id:Int) -> AnyPublisher<GameDetailResponse, Error>
    
}

final class RemoteDataSource: NSObject {
    
    private let apiKey = "161deabe57214ce389e3af3573aad03d"
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getGames() -> AnyPublisher<GamesResponse, Error> {
        return Future<GamesResponse, Error> { completion in
            if let url = URL(string: "\(API.baseUrl)?key=\(self.apiKey)") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(id:Int) -> AnyPublisher<GameDetailResponse, Error> {
        return Future<GameDetailResponse, Error> { completion in
            if let url = URL(string: "\(API.baseUrl)/\(id)?key=\(self.apiKey)") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    
}
