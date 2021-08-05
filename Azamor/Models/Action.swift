//
//  Action.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/02.
//

import Foundation
import RealmSwift

class Action: Object {
    @objc dynamic var Name: String = ""
    @objc dynamic var Discription: String = ""
    @objc dynamic var ActionAudioString: String = ""
    @objc dynamic var ActionImageString: String = ""
    
    @objc dynamic var SpecialEffect: String = ""
    
    @objc dynamic var isDamageAction: Bool = false
    @objc dynamic var Damage: Int = -1
    @objc dynamic var DamageType: String = ""
    @objc dynamic var requiresSave: Bool = false
    @objc dynamic var DC: Int = -1
    @objc dynamic var SaveType: String = ""
    
    @objc dynamic var isBuffAction: Bool = false
    
    @objc dynamic var HitPoints: Int = -1
    @objc dynamic var AC: Int = -1
    
    @objc dynamic var Strength: Int = -1
    @objc dynamic var Dexterity: Int = -1
    @objc dynamic var Constitution: Int = -1
    @objc dynamic var Wisdom: Int = -1
    @objc dynamic var Intelligence: Int = -1
    @objc dynamic var Charisma: Int = -1
    
    @objc dynamic var AttackMod: Int = -1

    
    var WeaponAction = LinkingObjects(fromType: Item.self, property: "WeaponAction")
    var PotionAction = LinkingObjects(fromType: Item.self, property: "PotionAction")
    var DamageAction = LinkingObjects(fromType: Item.self, property: "DmgAction")
    
    var CharacterAction1 = LinkingObjects(fromType: PlayerCharacter.self, property: "Action1")
    var CharacterAction2 = LinkingObjects(fromType: PlayerCharacter.self, property: "Action2")
    var CharacterAction3 = LinkingObjects(fromType: PlayerCharacter.self, property: "Action3")
    var CharacterAction4 = LinkingObjects(fromType: PlayerCharacter.self, property: "Action4")
    
    var EnemyActions = LinkingObjects(fromType: Enemy.self, property: "actions")
}
