//
//  GameEntity.swift
//  GameCatalogue2
//
//  Created by Febrian on 02/04/24.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var ratingTop: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
