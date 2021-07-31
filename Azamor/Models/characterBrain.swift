//
//  GameStateBrain.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/08.
//

import Foundation
import RealmSwift

class characterBrain {
    
    let realm = try! Realm()
    var currentCharacter: PlayerCharacter?
    
    func initCharacter(){
        let game =  realm.objects(Game.self).first
        currentCharacter = game!.GamePlayerCharacter
        
        var hpMod = 0
        var acMod = 0
        var attackMod = 0
        
        var strengthMod = 0
        var dexterityMod = 0
        var constituitionMod = 0
        var wisdomMod = 0
        var intelligenceMod = 0
        var charismaMod = 0
        
        if currentCharacter!.WeaponSlot1 == true {
            hpMod = hpMod + currentCharacter!.Weapon1!.HitPointsMod
            acMod = acMod + currentCharacter!.Weapon1!.ACMod
            attackMod = attackMod + currentCharacter!.Weapon1!.AttackMod
            
            strengthMod = strengthMod + currentCharacter!.Weapon1!.StrengthMod
            dexterityMod = dexterityMod + currentCharacter!.Weapon1!.DexterityMod
            constituitionMod = constituitionMod + currentCharacter!.Weapon1!.ConstitutionMod
            wisdomMod = wisdomMod + currentCharacter!.Weapon1!.WisdomMod
            intelligenceMod = intelligenceMod + currentCharacter!.Weapon1!.IntelligenceMod
            charismaMod = charismaMod + currentCharacter!.Weapon1!.CharismaMod
            
            do {
                try realm.write {
                    currentCharacter!.setValue(currentCharacter!.Weapon1!.WeaponAction, forKey: "Action1")
                }
            } catch  {
                print(error)
            }
            
            do {
                try realm.write {
                    currentCharacter!.setValue(true, forKey: "ActionSlotActive1")
                }
            } catch  {
                print(error)
            }
        }
        
        if currentCharacter!.WeaponSlot2 == true {
            hpMod = hpMod + currentCharacter!.Weapon2!.HitPointsMod
            acMod = acMod + currentCharacter!.Weapon2!.ACMod
            attackMod = attackMod + currentCharacter!.Weapon2!.AttackMod
            
            strengthMod = strengthMod + currentCharacter!.Weapon2!.StrengthMod
            dexterityMod = dexterityMod + currentCharacter!.Weapon2!.DexterityMod
            constituitionMod = constituitionMod + currentCharacter!.Weapon2!.ConstitutionMod
            wisdomMod = wisdomMod + currentCharacter!.Weapon2!.WisdomMod
            intelligenceMod = intelligenceMod + currentCharacter!.Weapon2!.IntelligenceMod
            charismaMod = charismaMod + currentCharacter!.Weapon2!.CharismaMod
            
            do {
                try realm.write {
                    currentCharacter!.setValue(currentCharacter!.Weapon2!.WeaponAction, forKey: "Action2")
                }
            } catch  {
                print(error)
            }
            
            do {
                try realm.write {
                    currentCharacter!.setValue(true, forKey: "ActionSlotActive2")
                }
            } catch  {
                print(error)
            }
        }
        
        if currentCharacter!.ArmorSlot == true {
            hpMod = hpMod + currentCharacter!.Armor!.HitPointsMod
            acMod = acMod + currentCharacter!.Armor!.ACMod
            attackMod = attackMod + currentCharacter!.Armor!.AttackMod
            
            strengthMod = strengthMod + currentCharacter!.Armor!.StrengthMod
            dexterityMod = dexterityMod + currentCharacter!.Armor!.DexterityMod
            constituitionMod = constituitionMod + currentCharacter!.Armor!.ConstitutionMod
            wisdomMod = wisdomMod + currentCharacter!.Armor!.WisdomMod
            intelligenceMod = intelligenceMod + currentCharacter!.Armor!.IntelligenceMod
            charismaMod = charismaMod + currentCharacter!.Armor!.CharismaMod
        
        }
        
        if currentCharacter!.RingSlot1 == true {
            hpMod = hpMod + currentCharacter!.Ring1!.HitPointsMod
            acMod = acMod + currentCharacter!.Ring1!.ACMod
            attackMod = attackMod + currentCharacter!.Ring1!.AttackMod
            
            strengthMod = strengthMod + currentCharacter!.Ring1!.StrengthMod
            dexterityMod = dexterityMod + currentCharacter!.Ring1!.DexterityMod
            constituitionMod = constituitionMod + currentCharacter!.Ring1!.ConstitutionMod
            wisdomMod = wisdomMod + currentCharacter!.Ring1!.WisdomMod
            intelligenceMod = intelligenceMod + currentCharacter!.Ring1!.IntelligenceMod
            charismaMod = charismaMod + currentCharacter!.Ring1!.CharismaMod
        
        }
        
        hpMod = hpMod + 30
        acMod = acMod + 10

        do {
            try realm.write {
                currentCharacter!.setValue(attackMod, forKey: "AttackMod")
            }
        } catch  {
            print(error)
        }
        
        do {
            try realm.write {
                currentCharacter!.setValue(hpMod, forKey: "HitPoints")
            }
        } catch  {
            print(error)
        }
        
        do {
            try realm.write {
                currentCharacter!.setValue(acMod, forKey: "AC")
            }
        } catch  {
            print(error)
        }
        
        do {
            try realm.write {
                currentCharacter!.setValue(strengthMod, forKey: "Strength")
            }
        } catch  {
            print(error)
        }
        
        do {
            try realm.write {
                currentCharacter!.setValue(dexterityMod, forKey: "Dexterity")
            }
        } catch  {
            print(error)
        }
        
        do {
            try realm.write {
                currentCharacter!.setValue(constituitionMod, forKey: "Constitution")
            }
        } catch  {
            print(error)
        }
        
        do {
            try realm.write {
                currentCharacter!.setValue(wisdomMod, forKey: "Wisdom")
            }
        } catch  {
            print(error)
        }
        
        do {
            try realm.write {
                currentCharacter!.setValue(intelligenceMod, forKey: "Intelligence")
            }
        } catch  {
            print(error)
        }
        
        do {
            try realm.write {
                currentCharacter!.setValue(charismaMod, forKey: "Charisma")
            }
        } catch  {
            print(error)
        }
    }
    
    func changeHP(amount: Int){
        var newHP = currentCharacter!.CurrentHitPoints + amount
        if newHP > currentCharacter!.HitPoints {newHP = currentCharacter!.HitPoints}
        do {
            try realm.write {
                currentCharacter!.setValue(newHP, forKey: "CurrentHitPoints")
            }
        } catch  {
            print(error)
        }
    }
    
    func resetHP() {
        do {
            try realm.write {
                currentCharacter!.setValue(currentCharacter!.HitPoints, forKey: "CurrentHitPoints")
            }
        } catch  {
            print(error)
        }
    }

    func equipItem(item: Item, slot: Int) {
        do {
            try realm.write {
                
                switch slot {
                case 1:
                    currentCharacter!.setValue(item, forKey: "Weapon1")
                case 2:
                    currentCharacter!.setValue(item, forKey: "Weapon2")
                case 3:
                    currentCharacter!.setValue(item, forKey: "Armor")
                case 4:
                    currentCharacter!.setValue(item, forKey: "Ring1")
                case 5:
                    currentCharacter!.setValue(item, forKey: "Usable1")
                case 6:
                    currentCharacter!.setValue(item, forKey: "Usable2")
                default:
                    print("error equipping item")
                }
            }
        } catch  {
            print(error)
        }
        setSlotTrue(slot: slot)
    }
    
    func setSlotTrue(slot: Int) {
        do {
            try realm.write {
                switch slot {
                case 1:
                    currentCharacter!.setValue(true, forKey: "WeaponSlot1")
                case 2:
                    currentCharacter!.setValue(true, forKey: "WeaponSlot2")
                case 3:
                    currentCharacter!.setValue(true, forKey: "ArmorSlot")
                case 4:
                    currentCharacter!.setValue(true, forKey: "RingSlot1")
                case 5:
                    currentCharacter!.setValue(true, forKey: "UsableSlot1")
                case 6:
                    currentCharacter!.setValue(true, forKey: "UsableSlot2")
                default:
                    print("error equipping item")
                }
            }
        } catch  {
            print(error)
        }
    }
    
    func addItem(item: Item){
        do {
            try realm.write {
                currentCharacter!.items.append(item)
            }
        } catch  {
            print(error)
        }
    }
    
    func returnName() -> String {
        return currentCharacter!.Name
    }
    
    func returnImgString() -> String {
        return currentCharacter!.characterImageString
    }
    
    func maxHP() -> Int {
        return currentCharacter!.HitPoints
    }
    
    func tempHP() -> Int {
        return currentCharacter!.CurrentHitPoints
    }

    func returnAC() -> Int {
        return currentCharacter!.AC
    }
    
    func returnLevel() -> Int {
        return currentCharacter!.Level
    }
    
    func returnAttackMod() -> Int {
        return currentCharacter!.AttackMod
    }
    
    func returnStrengthMod() -> Int{
        return currentCharacter!.Strength
    }
    
    func returnDexterityMod() -> Int{
        print(currentCharacter!.Dexterity)
        return currentCharacter!.Dexterity
    }
    
    func returnConstitutionMod() -> Int{
        return currentCharacter!.Constitution
    }
    
    func returnWisdomMod() -> Int{
        return currentCharacter!.Wisdom
    }
    
    func returnIntelligenceMod() -> Int{
        return currentCharacter!.Intelligence
    }
    
    func returnCharismaMod() -> Int{
        return currentCharacter!.Charisma
    }
    
    func A1isActive() -> Bool {
        return currentCharacter!.ActionSlotActive1
    }
    
    func A2isActive() -> Bool {
        return currentCharacter!.ActionSlotActive2
    }
    
    func A3isActive() -> Bool {
        return currentCharacter!.ActionSlotActive3
    }
    
    func A4isActive() -> Bool {
        return currentCharacter!.ActionSlotActive4
    }
    
    func W1isActive() -> Bool {
        return currentCharacter!.WeaponSlot1
    }
    
    func W2isActive() -> Bool {
        return currentCharacter!.WeaponSlot2
    }
     
    func ArmisActive() -> Bool{
        return currentCharacter!.ArmorSlot
    }
    
    func R1isActive() -> Bool{
        return currentCharacter!.RingSlot1
    }
    
    func R2isActive() -> Bool {
        return currentCharacter!.RingSlot2
    }
    
    func U1isActive() -> Bool {
        return currentCharacter!.UsableSlot1
    }
    
    func U2isActive() -> Bool {
        return currentCharacter!.UsableSlot2
    }
    
    func returnAction1() -> Action {
        return currentCharacter!.Action1!
    }
    
    func returnAction2() -> Action {
        return currentCharacter!.Action2!
    }
    
    func returnAction3() -> Action {
        return currentCharacter!.Action3!
    }
    
    func returnAction4() -> Action {
        return currentCharacter!.Action4!
    }
    
    func returnUsableAction1() -> Action {
        if currentCharacter?.Usable1?.PotionActive == true{
            return currentCharacter!.Usable1!.PotionAction!
        }
        else if currentCharacter?.Usable1?.DamageActive == true {
            return currentCharacter!.Usable1!.DmgAction!
        }
        else {
            return Action()
        }
    }
    
    func returnUsableAction2() -> Action {
        if currentCharacter?.Usable2?.PotionActive == true{
            return currentCharacter!.Usable2!.PotionAction!
        }
        else if currentCharacter?.Usable2?.DamageActive == true {
            return currentCharacter!.Usable2!.DmgAction!
        }
        else {
            return Action()
        }
    }
    
    func returnInventoryItem(slot: Int) -> Item {
        switch slot {
        case 1:
            return currentCharacter!.Weapon1!
        case 2:
            return currentCharacter!.Weapon2!
        case 3:
            return currentCharacter!.Armor!
        case 4:
            return currentCharacter!.Ring1!
        case 5:
            return currentCharacter!.Usable1!
        case 6:
            return currentCharacter!.Usable2!
        default:
            return Item()
        }
    }
    
    func returnItem(pred: String) -> Item {
        return currentCharacter!.items.filter(pred).first!
    }
    
    func returnItemList(pred: String) -> Results<Item>?{
        return currentCharacter!.items.filter(pred)
    }
  
}
