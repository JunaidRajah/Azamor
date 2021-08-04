//
//  InventoryViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift
import AVFoundation

class InventoryViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    let realm = try! Realm()
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentCharacter = characterBrain.characterInstance
    
    @IBOutlet weak var Weapon1Image: UIImageView!
    @IBOutlet weak var Weapon2Image: UIImageView!
    @IBOutlet weak var ArmorImage: UIImageView!
    @IBOutlet weak var RingImage: UIImageView!
    @IBOutlet weak var Usable1Image: UIImageView!
    @IBOutlet weak var Usable2Image: UIImageView!
    
    @IBOutlet weak var charImage: UIImageView!
    
    @IBOutlet weak var Weapon1Button: UIButton!
    @IBOutlet weak var Weapon2Button: UIButton!
    @IBOutlet weak var ArmorButton: UIButton!
    @IBOutlet weak var Ring1Button: UIButton!
    @IBOutlet weak var Usable1Button: UIButton!
    @IBOutlet weak var Usable2Button: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var indexToChange = 0
    var isFromMain = false
    var isFromStory = false
    var isFromItem = false
    var isFromEncounter = false
    var currentTrack: String?
    
    var isPlayerTurn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCharacter.initCharacter()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        charImage.image = UIImage(named: realm.objects(Game.self).first!.GamePlayerCharacter!.characterImageString)
        
        if currentCharacter.W1isActive() == true {
            Weapon1Image.image = UIImage(named: "\(currentCharacter.returnInventoryItem(slot: 1).ItemImageString)")
        } else {
            Weapon1Image.image = UIImage(named: "noItem")
        }
        
        if currentCharacter.W2isActive() == true {
            Weapon2Image.image = UIImage(named: "\(currentCharacter.returnInventoryItem(slot: 2).ItemImageString)")
        } else {
            Weapon2Image.image = UIImage(named: "noItem")
        }
        
        if currentCharacter.ArmisActive() == true {
            ArmorImage.image = UIImage(named: "\(currentCharacter.returnInventoryItem(slot: 3).ItemImageString)")
        } else {
            ArmorImage.image = UIImage(named: "noItem")
        }
        
        if currentCharacter.R1isActive() == true {
            RingImage.image = UIImage(named: "\(currentCharacter.returnInventoryItem(slot: 4).ItemImageString)")
        } else {
            RingImage.image = UIImage(named: "noItem")
        }
        
        if currentCharacter.U1isActive() == true {
            Usable1Image.image = UIImage(named: "\(currentCharacter.returnInventoryItem(slot: 5).ItemImageString)")
        } else {
            Usable1Image.image = UIImage(named: "noItem")
        }
        
        if currentCharacter.U2isActive() == true {
            Usable2Image.image = UIImage(named: "\(currentCharacter.returnInventoryItem(slot: 6).ItemImageString)")
        } else {
            Usable2Image.image = UIImage(named: "noItem")
        }
    }
    
    @IBAction func itemButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        indexToChange = sender.tag
        switch sender.tag {
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
        coordinator?.inventoryToList(vc: self)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        if isFromMain == true {
            coordinator?.inventoryToMain(vc: self)
        }
        else if isFromStory == true {
            coordinator?.inventoryToStory(vc: self)
        }
        else if isFromItem == true {
            coordinator?.inventoryToItem(vc: self)
        }
        else if isFromEncounter == true {
            coordinator?.inventoryToEncounter(vc: self)
        }
        
    }
}
