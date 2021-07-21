//
//  Game.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/06.
//

import Foundation
import RealmSwift

class Game: Object {

    @objc dynamic var GameSaveNumber: Int = 0
    @objc dynamic var CurrentStoryTab: String = ""
    @objc dynamic var GamePlayerCharacter: PlayerCharacter?
    
}
