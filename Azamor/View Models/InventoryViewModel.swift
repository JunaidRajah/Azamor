//
//  InventoryViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation
import RealmSwift

class InventoryViewModel {
    
    let realm = try! Realm()
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentCharacter = characterBrain.characterInstance
    
    var indexToChange = 0
    
    var charImageString: String?
    var Weapon1ImageString: String?
    var Weapon2ImageString: String?
    var ArmorImageString: String?
    var RingImageString: String?
    var Usable1ImageString: String?
    var Usable2ImageString: String?
    
    init() {
        currentCharacter.initCharacter()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        charImageString = realm.objects(Game.self).first!.GamePlayerCharacter!.characterImageString
        
        if currentCharacter.W1isActive() == true {
            Weapon1ImageString = "\(currentCharacter.returnInventoryItem(slot: 1).ItemImageString)"
        } else {
            Weapon1ImageString = "noItem"
        }
        
        if currentCharacter.W2isActive() == true {
            Weapon2ImageString = "\(currentCharacter.returnInventoryItem(slot: 2).ItemImageString)"
        } else {
            Weapon2ImageString = "noItem"
        }
        
        if currentCharacter.ArmisActive() == true {
            ArmorImageString = "\(currentCharacter.returnInventoryItem(slot: 3).ItemImageString)"
        } else {
            ArmorImageString = "noItem"
        }
        
        if currentCharacter.R1isActive() == true {
            RingImageString = "\(currentCharacter.returnInventoryItem(slot: 4).ItemImageString)"
        } else {
            RingImageString = "noItem"
        }
        
        if currentCharacter.U1isActive() == true {
            Usable1ImageString = "\(currentCharacter.returnInventoryItem(slot: 5).ItemImageString)"
        } else {
            Usable1ImageString = "noItem"
        }
        
        if currentCharacter.U2isActive() == true {
            Usable2ImageString = "\(currentCharacter.returnInventoryItem(slot: 6).ItemImageString)"
        } else {
            Usable2ImageString = "noItem"
        }
    }
    
    func itemButtonPressed(button: Int) {
        aB.playButtonSound("buttonClicked")
        indexToChange = button
        switch indexToChange {
        case 1:
            gameLogic.itemListToSend = currentCharacter.returnItemList(pred: "isWeapon = true")
        case 2:
            gameLogic.itemListToSend = currentCharacter.returnItemList(pred: "isWeapon = true")
        case 3:
            gameLogic.itemListToSend = currentCharacter.returnItemList(pred: "isArmor= true")
        case 4:
            gameLogic.itemListToSend = currentCharacter.returnItemList(pred: "isWearable = true")
        case 5:
            gameLogic.itemListToSend = currentCharacter.returnItemList(pred: "isUsable = true")
        case 6:
            gameLogic.itemListToSend = currentCharacter.returnItemList(pred: "isUsable = true")
        default:
            print("error")
        }
    }
    
    func playButtonSound() {
        aB.playButtonSound("buttonClicked")
    }
}
