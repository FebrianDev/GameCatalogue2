//
//  GameTransform.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import Foundation

public struct GameTransform : Mapper {
    
    public init() {
    }
    
    public typealias Response = [GameResponse]
    public typealias Entity = Any
    public typealias Domain = [GameModel]
    
    public func transformResponseToEntity(response: [GameResponse]) -> Any {
        fatalError()
    }
    
    public func transformResponseToDomain(response: [GameResponse]) -> [GameModel] {
        return response.map { result in
            return GameModel(
                id: result.id ?? 1 ,
                name: result.name ?? "",
                rating: result.rating ?? 0.0,
                released: result.released ?? "" ,
                background_image: result.background_image ?? ""
            )
            
        }
    }
    
    public func transformEntityToDomain(entity: Any) -> [GameModel] {
        fatalError()
    }
    
    public func transformDomainToEntiry(domain: [GameModel]) -> Any {
        fatalError()
    }
    
}
