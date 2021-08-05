//
//  Item.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/01.
//

import Foundation
import RealmSwift

class Item: Object{
    
    @objc dynamic var Name: String = ""
    @objc dynamic var Discription: String = ""
    @objc dynamic var Equipped: Bool = false
    @objc dynamic var Quantity: Int = 0
    
    @objc dynamic var ItemImageString: String = ""
    
    var CharacterItem = LinkingObjects(fromType: PlayerCharacter.self, property: "items")
    var StoryItem = LinkingObjects(fromType: StoryTab.self, property: "items")
    
    @objc dynamic var HitPointsMod: Int = 0
    @objc dynamic var ACMod: Int = 0
    
    @objc dynamic var StrengthMod: Int = 0
    @objc dynamic var DexterityMod: Int = 0
    @objc dynamic var ConstitutionMod: Int = 0
    @objc dynamic var WisdomMod: Int = 0
    @objc dynamic var IntelligenceMod: Int = 0
    @objc dynamic var CharismaMod: Int = 0
    
    @objc dynamic var isWeapon: Bool = false
    @objc dynamic var isArmor: Bool = false
    @objc dynamic var isWearable: Bool = false
    @objc dynamic var isUsable: Bool = false
    
    @objc dynamic var WeaponAction: Action?
    @objc dynamic var AttackMod: Int = 0
    
    var CharacterArmor = LinkingObjects(fromType: PlayerCharacter.self, property: "Armor")
    var CharacterRing1 = LinkingObjects(fromType: PlayerCharacter.self, property: "Ring1")
    var CharacterRing2 = LinkingObjects(fromType: PlayerCharacter.self, property: "Ring2")
    
    var CharacterWeapon1 = LinkingObjects(fromType: PlayerCharacter.self, property: "Weapon1")
    var CharacterWeapon2 = LinkingObjects(fromType: PlayerCharacter.self, property: "Weapon2")
    
    @objc dynamic var PotionActive: Bool = false
    @objc dynamic var DamageActive: Bool = false
    
    @objc dynamic var PotionAction: Action?
    @objc dynamic var DmgAction: Action?
    
    var CharacterUsable1 = LinkingObjects(fromType: PlayerCharacter.self, property: "Usable1")
    var CharacterUsable2 = LinkingObjects(fromType: PlayerCharacter.self, property: "Usable2")
}
