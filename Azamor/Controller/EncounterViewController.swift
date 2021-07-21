//
//  EncounterViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift
import AVFoundation

class EncounterViewController: UIViewController {
    
    let realm = try! Realm()
    var aB = audioBrain()
    
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var PlayerCharacterPortait: UIImageView!
    @IBOutlet weak var EnemyImage: UIImageView!
    @IBOutlet weak var DiceImage: UIImageView!
    @IBOutlet weak var EncounterTitleLabel: UILabel!
    @IBOutlet weak var PlayerHPLabel: UILabel!
    @IBOutlet weak var PlayerArmorLabel: UILabel!
    @IBOutlet weak var PlayerAttackLabel: UILabel!
    @IBOutlet weak var EnemyHPLabel: UILabel!
    @IBOutlet weak var EnemyArmorLabel: UILabel!
    @IBOutlet weak var EnemyAttackLabel: UILabel!
    @IBOutlet weak var EnemyDamageLabel: UILabel!
    @IBOutlet weak var EnemyNameLabel: UILabel!
    @IBOutlet weak var PlayerNameLabel: UILabel!
    @IBOutlet weak var DiceOutcomeLabel: UILabel!
    
    
    @IBOutlet weak var Weapon1Back: UIImageView!
    @IBOutlet weak var Weapon2Back: UIImageView!
    @IBOutlet weak var Normal1Back: UIImageView!
    @IBOutlet weak var Normal2Back: UIImageView!
    @IBOutlet weak var Usable1Back: UIImageView!
    @IBOutlet weak var Usable2Back: UIImageView!
    @IBOutlet weak var ReturnBack: UIImageView!
    @IBOutlet weak var DiceOverlay: UIImageView!
    
    @IBOutlet weak var WeaponAction1Label: UILabel!
    @IBOutlet weak var WeaponAction2Label: UILabel!
    @IBOutlet weak var NormalAction1Label: UILabel!
    @IBOutlet weak var NormalAction2Label: UILabel!
    @IBOutlet weak var UsableAction1Label: UILabel!
    @IBOutlet weak var UsableAction2Label: UILabel!
    
    @IBOutlet weak var WeaponAction1Button: UIButton!
    @IBOutlet weak var WeaponAction2Button: UIButton!
    @IBOutlet weak var NormalAction1Button: UIButton!
    @IBOutlet weak var NormalAction2Button: UIButton!
    @IBOutlet weak var UsableAction1Button: UIButton!
    @IBOutlet weak var UsableAction2Button: UIButton!
    
    @IBOutlet weak var InventoryButton: UIButton!
    
    @IBOutlet weak var D20Label: UILabel!
    @IBOutlet weak var ReturnButton: UIButton!
    @IBOutlet weak var ReturnLabel: UILabel!
    
    var currentStoryTabString: String?
    var nextStoryTabString: String?
    var storyTabToReturn: String?
    var currentTrack: String?
    
    var currentStoryTab: StoryTab?
    var currentCharacter = characterBrain()
    var currentEnemy: Enemy?
    var EncounterItems: List<Item>?
    var action1: Action?
    var action2: Action?
    var action3: Action?
    var action4: Action?
    var action5: Action?
    var action6: Action?
    
    var isReturnedFromInventory = false
    var isPlayerTurn: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let game = realm.objects(Game.self).first
        let storyTab = realm.objects(StoryTab.self)
        let pred = "StoryTabID = '\(String(describing: currentStoryTabString!))'"
        print(pred)
        currentStoryTab = storyTab.filter(pred).first
        print(currentStoryTab?.StoryTabID ?? "error getting correct tab")
        
        currentCharacter.initCharacter()
        nextStoryTabString = currentStoryTab?.StoryTabMoveID1
        currentEnemy = currentStoryTab?.enemies.first
        EncounterItems = currentStoryTab?.items
        
        if isReturnedFromInventory == false {
            do {
                let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
                try realm.write {
                    enemy.setValue(currentEnemy!.HitPoints, forKey: "CurrentHitPoints")
                }
            } catch  {
                print(error)
            }
        }
        else {
            isReturnedFromInventory = false
        }
        
        addActions()
        initView()
        initBackgroundMusic()
    }
    
    func initView() {
        
        if currentEnemy?.EnemyImageString != "" {
            EnemyImage.image = UIImage(named: currentEnemy!.EnemyImageString)
        }
        PlayerCharacterPortait.image = UIImage(named: currentCharacter.returnImgString())
        BackgroundImage.image = UIImage(named: currentStoryTab!.StoryTabBackgroundImageString)
        EncounterTitleLabel.text = currentStoryTab?.StoryTabDiscription
        PlayerHPLabel.text = "HP: \(String(describing: currentCharacter.tempHP()))"
        PlayerArmorLabel.text = "Armor: \(String(describing: currentCharacter.returnAC()))"
        PlayerAttackLabel.text = "Attack: \(String(describing: currentCharacter.returnAttackMod()))"
        
        EnemyHPLabel.text = "HP: \(String(describing: currentEnemy!.CurrentHitPoints))"
        EnemyArmorLabel.text = "Armor: \(String(describing: currentEnemy!.AC))"
        EnemyAttackLabel.text = "Attack: \(String(describing: currentEnemy!.AttackMod))"
        EnemyDamageLabel.text = "Damage: \(String(describing: currentEnemy!.actions.first!.Damage))"
        EnemyNameLabel.text = "\(String(describing: currentEnemy!.Name))"
        PlayerNameLabel.text = currentCharacter.returnName()
    }
    
    // if else if else if else i need to refactor this big time
    
    func addActions() {
        if currentCharacter.A1isActive() == true {
            action1 = currentCharacter.returnAction1()
            WeaponAction1Label.text = action1?.Name
        } else {
            WeaponAction1Label.isHidden = true
            WeaponAction1Button.isHidden = true
            Weapon1Back.isHidden = true
        }
        
        if currentCharacter.A2isActive() == true {
            action2 = currentCharacter.returnAction2()
            WeaponAction2Label.text = action2?.Name
            
        } else {
            WeaponAction2Label.isHidden = true
            WeaponAction2Button.isHidden = true
            Weapon2Back.isHidden = true
        }
        
        if currentCharacter.A3isActive() == true {
            action3 = currentCharacter.returnAction3()
            NormalAction1Label.text = action3?.Name
        } else {
            NormalAction1Label.isHidden = true
            NormalAction1Button.isHidden = true
            Normal1Back.isHidden = true
        }
        
        if currentCharacter.A4isActive() == true {
            action4 = currentCharacter.returnAction4()
            NormalAction2Label.text = action4?.Name
        } else {
            NormalAction2Label.isHidden = true
            NormalAction2Button.isHidden = true
            Normal2Back.isHidden = true
        }
        
        if currentCharacter.U1isActive() == true {
            if currentCharacter.returnInventoryItem(slot: 5).PotionActive == true{
                action5 = currentCharacter.returnUsableAction1()
                UsableAction1Label.text = action5?.Name
            }
            if currentCharacter.returnInventoryItem(slot: 5).DamageActive == true {
                action5 = currentCharacter.returnUsableAction1()
                UsableAction1Label.text = action5?.Name
            }
            
        } else {
            UsableAction1Label.isHidden = true
            UsableAction1Button.isHidden = true
            Usable1Back.isHidden = true
        }
        
        if currentCharacter.U2isActive() == true {
            if currentCharacter.returnInventoryItem(slot: 6).PotionActive == true{
                action6 = currentCharacter.returnUsableAction2()
                UsableAction2Label.text = action6?.Name
            }
            if currentCharacter.returnInventoryItem(slot: 6).DamageActive == true {
                action6 = currentCharacter.returnUsableAction2()
                UsableAction2Label.text = action6?.Name
            }
        } else {
            UsableAction2Label.isHidden = true
            UsableAction2Button.isHidden = true
            Usable2Back.isHidden = true
        }
    }
    
    func roll(Mod: Int) -> Int {
        
        var roll =  Int.random(in: 1...20)
        roll = roll + Mod
        print(roll)
        return roll
    }
    
    //dice show/hide functions
    
    func showDice(){
        ReturnBack.isHidden = false
        ReturnButton.isHidden = false
        DiceOverlay.isHidden = false
        DiceImage.isHidden = false
        D20Label.isHidden = false
        DiceOutcomeLabel.isHidden = false
        ReturnLabel.isHidden = false
        
        WeaponAction1Button.isEnabled = false
        WeaponAction2Button.isEnabled = false
        NormalAction1Button.isEnabled = false
        NormalAction2Button.isEnabled = false
        UsableAction1Button.isEnabled = false
        UsableAction2Button.isEnabled = false
        
        InventoryButton.isEnabled = false
    }
    
    func hideDice(){
        ReturnBack.isHidden = true
        ReturnButton.isHidden = true
        DiceOverlay.isHidden = true
        DiceImage.isHidden = true
        D20Label.isHidden = true
        DiceOutcomeLabel.isHidden = true
        ReturnLabel.isHidden = true
        
        WeaponAction1Button.isEnabled = true
        WeaponAction2Button.isEnabled = true
        NormalAction1Button.isEnabled = true
        NormalAction2Button.isEnabled = true
        UsableAction1Button.isEnabled = true
        UsableAction2Button.isEnabled = true
        
        InventoryButton.isEnabled = true
    }
    
    func initBackgroundMusic(){
        let storyBack = currentStoryTab!.StoryTabMusicString
        if storyBack != currentTrack {
            aB.stopSoundBack()
            aB.playBackgroundSound(storyBack)
            currentTrack = storyBack
            
        }
    }
    //Switch not working as i expected seperate this is basically the same code 6 times
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        isPlayerTurn = false
        switch sender.tag {
        case 1:
            let attackRoll = roll(Mod: currentCharacter.returnAttackMod())
            if attackRoll >= currentEnemy!.AC {
                let newHP = currentEnemy!.CurrentHitPoints - action1!.Damage
                
                do {
                    let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
                    try realm.write {
                        enemy.setValue(newHP, forKey: "CurrentHitPoints")
                    }
                } catch  {
                    print(error)
                }
                DiceOutcomeLabel.text = "Your Attack Roll Hit and Dealt \(action1!.Damage) Damage to The \(currentEnemy!.Name)"
            } else {
                DiceOutcomeLabel.text = "Your Attack Roll Missed"
            }
            D20Label.text = "\(attackRoll)"
            showDice()
        case 2:
            let attackRoll = roll(Mod: currentCharacter.returnAttackMod())
            if attackRoll >= currentEnemy!.AC {
                let newHP = currentEnemy!.CurrentHitPoints - action2!.Damage
                
                do {
                    let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
                    try realm.write {
                        enemy.setValue(newHP, forKey: "CurrentHitPoints")
                    }
                } catch  {
                    print(error)
                }
                DiceOutcomeLabel.text = "Your Attack Roll Hit and Dealt \(action2!.Damage) Damage to The \(currentEnemy!.Name)"
            } else {
                DiceOutcomeLabel.text = "Your Attack Roll Missed"
            }
            D20Label.text = "\(attackRoll)"
            showDice()
        case 3:
            if action3!.isDamageAction == true {
                let attackRoll = roll(Mod: currentCharacter.returnAttackMod())
                if attackRoll >= currentEnemy!.AC {
                    let newHP = currentEnemy!.CurrentHitPoints - action3!.Damage
                    
                    do {
                        let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
                        try realm.write {
                            enemy.setValue(newHP, forKey: "CurrentHitPoints")
                        }
                    } catch  {
                        print(error)
                    }
                    DiceOutcomeLabel.text = "Your Attack Roll Hit and Dealt \(action3!.Damage) Damage to The \(currentEnemy!.Name)"
                } else {
                    DiceOutcomeLabel.text = "Your Attack Roll Missed"
                }
                D20Label.text = "\(attackRoll)"
                showDice()
            } else if action3!.isBuffAction {
                currentCharacter.changeHP(amount: action3!.HitPoints)
                
                showDice()
                returnFunction()
            }
        case 4:
            if action4!.isDamageAction == true {
                let attackRoll = roll(Mod: currentCharacter.returnAttackMod())
                if attackRoll >= currentEnemy!.AC {
                    let newHP = currentEnemy!.CurrentHitPoints - action4!.Damage
                    
                    do {
                        let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
                        try realm.write {
                            enemy.setValue(newHP, forKey: "CurrentHitPoints")
                        }
                    } catch  {
                        print(error)
                    }
                    DiceOutcomeLabel.text = "Your Attack Roll Hit and Dealt \(action4!.Damage) Damage to The \(currentEnemy!.Name)"
                } else {
                    DiceOutcomeLabel.text = "Your Attack Roll Missed"
                }
                D20Label.text = "\(attackRoll)"
                showDice()
            } else if action4!.isBuffAction {
                currentCharacter.changeHP(amount: action4!.HitPoints)
                
                showDice()
                returnFunction()
            }
        case 5:
            if action5!.isDamageAction == true {
                let attackRoll = roll(Mod: currentCharacter.returnAttackMod())
                if attackRoll >= currentEnemy!.AC {
                    let newHP = currentEnemy!.CurrentHitPoints - action5!.Damage
                    
                    do {
                        let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
                        try realm.write {
                            enemy.setValue(newHP, forKey: "CurrentHitPoints")
                        }
                    } catch  {
                        print(error)
                    }
                    DiceOutcomeLabel.text = "Your Attack Roll Hit and Dealt \(action5!.Damage) Damage to The \(currentEnemy!.Name)"
                } else {
                    DiceOutcomeLabel.text = "Your Attack Roll Missed"
                }
                D20Label.text = "\(attackRoll)"
                showDice()
            } else if action5!.isBuffAction {
                currentCharacter.changeHP(amount: action5!.HitPoints)
                showDice()
                returnFunction()
            }
        case 6:
            if action6!.isDamageAction == true {
                let attackRoll = roll(Mod: currentCharacter.returnAttackMod())
                if attackRoll >= currentEnemy!.AC {
                    let newHP = currentEnemy!.CurrentHitPoints - action6!.Damage
                    
                    do {
                        let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
                        try realm.write {
                            enemy.setValue(newHP, forKey: "CurrentHitPoints")
                        }
                    } catch  {
                        print(error)
                    }
                    DiceOutcomeLabel.text = "Your Attack Roll Hit and Dealt \(action6!.Damage) Damage to The \(currentEnemy!.Name)"
                } else {
                    DiceOutcomeLabel.text = "Your Attack Roll Missed"
                }
                D20Label.text = "\(attackRoll)"
                showDice()
            } else if action6!.isBuffAction {
                currentCharacter.changeHP(amount: action6!.HitPoints)
                showDice()
                returnFunction()
            }
        default:
            print("error")
        }
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        performSegue(withIdentifier: "encounterToInventory", sender: self)
    }
    
    func returnFunction() {
        if isPlayerTurn == false {
            if currentEnemy!.CurrentHitPoints > 0 {
                let attackRoll = roll(Mod: currentEnemy!.AttackMod)
                if attackRoll >= currentCharacter.returnAC() {
                    let newHP = 0 - currentEnemy!.actions.first!.Damage
                    currentCharacter.changeHP(amount: newHP)
                    DiceOutcomeLabel.text = "The \(currentEnemy!.Name) Attack Hit and Dealt \(currentEnemy!.actions.first!.Damage) Damage to You"
                }
                else {
                    DiceOutcomeLabel.text = "The \(currentEnemy!.Name) Attack Roll Missed"
                }
                D20Label.text = "\(attackRoll)"
                isPlayerTurn = true
            } else {
                do {
                    let game = realm.objects(Game.self).first
                    try realm.write {
                        game!.setValue(nextStoryTabString, forKey: "CurrentStoryTab")
                    }
                } catch  {
                    print(error)
                }
                aB.stopVoice()
                aB.playVoiceSound(nextStoryTabString!)
                performSegue(withIdentifier: "encounterToStory", sender: self)
            }
        } else {
            if currentCharacter.tempHP() <= 0 {
                currentCharacter.resetHP()
                do {
                    let game = realm.objects(Game.self).first
                    try realm.write {
                        game!.setValue(storyTabToReturn, forKey: "CurrentStoryTab")
                    }
                } catch  {
                    print(error)
                }
                performSegue(withIdentifier: "encounterToStory", sender: self)
            } else {
                
            }
            hideDice()
        }
        initView()
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        aB.playButtonSound("buttonClicked")
        returnFunction()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "encounterToInventory" {
            let destinationVC = segue.destination as! InventoryViewController
            destinationVC.currentStoryTabString = currentStoryTabString!
            destinationVC.isPlayerTurn = isPlayerTurn!
            destinationVC.storyTabToReturn = storyTabToReturn!
            destinationVC.isFromEncounter = true
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "encounterToStory" {
            let destinationVC = segue.destination as! StoryTabViewController
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
    }
    
}
