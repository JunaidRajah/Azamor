//
//  Character.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/01.
//

import Foundation
import RealmSwift

class PlayerCharacter: Object {
    
    @objc dynamic var Name: String = ""
    @objc dynamic var Class: String = ""
    @objc dynamic var characterImageString: String = ""
    
    @objc dynamic var HitPoints: Int = -1
    @objc dynamic var CurrentHitPoints: Int = -1
    @objc dynamic var AC: Int = -1
    @objc dynamic var Level: Int = -1
    @objc dynamic var Xp: Int = -1
    @objc dynamic var AttackMod: Int = -1
    
    @objc dynamic var Strength: Int = -1
    @objc dynamic var Dexterity: Int = -1
    @objc dynamic var Constitution: Int = -1
    @objc dynamic var Wisdom: Int = -1
    @objc dynamic var Intelligence: Int = -1
    @objc dynamic var Charisma: Int = -1
    
    //@objc dynamic var StatusEffect: String = ""
    
    @objc dynamic var ActionSlotActive1: Bool = false
    @objc dynamic var ActionSlotActive2: Bool = false
    @objc dynamic var ActionSlotActive3: Bool = false
    @objc dynamic var ActionSlotActive4: Bool = false
    
    @objc dynamic var Action1: Action?
    @objc dynamic var Action2: Action?
    @objc dynamic var Action3: Action?
    @objc dynamic var Action4: Action?
    
    @objc dynamic var WeaponSlot1: Bool = false
    @objc dynamic var WeaponSlot2: Bool = false
    
    @objc dynamic var Weapon1: Item?
    @objc dynamic var Weapon2: Item?
    
    @objc dynamic var ArmorSlot: Bool = false
    @objc dynamic var Armor: Item?
    
    @objc dynamic var RingSlot1: Bool = false
    @objc dynamic var RingSlot2: Bool = false
    
    @objc dynamic var Ring1: Item?
    @objc dynamic var Ring2: Item?
    
    @objc dynamic var UsableSlot1: Bool = false
    @objc dynamic var UsableSlot2: Bool = false
    
    @objc dynamic var Usable1: Item?
    @objc dynamic var Usable2: Item?
    
    let items = List<Item>()
    
    
}

class Enemy: Object {
    
    @objc dynamic var Name: String = ""
    @objc dynamic var Class: String = ""
    
    @objc dynamic var HitPoints: Int = -1
    @objc dynamic var CurrentHitPoints: Int = -1
    @objc dynamic var AC: Int = -1
    @objc dynamic var Level: Int = -1
    @objc dynamic var Xp: Int = -1
    @objc dynamic var AttackMod: Int = -1
    
    @objc dynamic var Strength: Int = -1
    @objc dynamic var Dexterity: Int = -1
    @objc dynamic var Constitution: Int = -1
    @objc dynamic var Wisdom: Int = -1
    @objc dynamic var Intelligence: Int = -1
    @objc dynamic var Charisma: Int = -1
    
    //@objc dynamic var StatusEffect: String = ""
    
    @objc dynamic var EnemyImageString: String = ""
    
    let actions = List<Action>()
    
    var EncounterEnemies = LinkingObjects(fromType: StoryTab.self, property: "enemies")
}
