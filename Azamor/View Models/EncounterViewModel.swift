//
//  EncounterViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation
import RealmSwift

class EncounterViewModel {
    
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentCharacter = characterBrain.characterInstance
    let realm = try! Realm()

    var currentStoryTab: StoryTab?
    var currentEnemy: Enemy?
    var EncounterItems: List<Item>?
    var action1: Action?
    var action2: Action?
    var action3: Action?
    var action4: Action?
    var action5: Action?
    var action6: Action?
    
    var EnemyImageString: String?
    var characterImageString: String?
    var StoryTabBackgroundImageString: String?
    var StoryTabDiscription: String?
    var tempHP: Int?
    var returnAC: Int?
    var returnAttackMod: Int?
    var CurrentHitPoints: Int?
    var AC: Int?
    var AttackMod: Int?
    var Damage: Int?
    var Name: String?
    var PlayerName: String?
    
    var WeaponAction1LabelText: String?
    var WeaponAction2LabelText: String?
    var NormalAction1LabelText: String?
    var NormalAction2LabelText: String?
    var UsableAction1LabelText: String?
    var UsableAction2LabelText: String?
    
    var DiceOutcomeLabelText: String?
    var D20LabelText: String?
    
    var attackRoll = 0
    
    var isReturnedFromInventory = false
    var isPlayerTurn: Bool?
    
    init() {
        currentCharacter.initCharacter()
        gameLogic.nextStoryTabString = gameLogic.getCurrentST().StoryTabMoveID1
        currentEnemy = gameLogic.getCurrentST().enemies.first
        EncounterItems = gameLogic.getCurrentST().items
        
        addActions()
        initView()
        //initBackgroundMusic()
    }
    
    func setEnemyHP() {
        do {
            let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
            try realm.write {
                enemy.setValue(currentEnemy!.HitPoints, forKey: "CurrentHitPoints")
            }
        } catch  {
            print(error)
        }
    }
    
    func updateEnemyHP(newHP: Int) {
        do {
            let enemy = realm.objects(Enemy.self).filter("Name = '\(String(describing: currentEnemy!.Name))'")
            try realm.write {
                enemy.setValue(newHP, forKey: "CurrentHitPoints")
            }
        } catch  {
            print(error)
        }
    }
    
    func checkImage() -> Bool{
        currentEnemy?.EnemyImageString != ""
    }
    
    func initView() {
        EnemyImageString = currentEnemy!.EnemyImageString
        characterImageString = currentCharacter.returnImgString()
        StoryTabBackgroundImageString = gameLogic.getCurrentST().StoryTabBackgroundImageString
        StoryTabDiscription = gameLogic.getCurrentST().StoryTabDiscription
        tempHP = currentCharacter.tempHP()
        returnAC = currentCharacter.returnAC()
        returnAttackMod = currentCharacter.returnAttackMod()
        CurrentHitPoints = currentEnemy!.CurrentHitPoints
        AC = currentEnemy!.AC
        AttackMod = currentEnemy!.AttackMod
        Damage = currentEnemy!.actions.first!.Damage
        Name = currentEnemy!.Name
        PlayerName = currentCharacter.returnName()
    }
    
    // if else if else if else i need to refactor this big time
    func isAction1Active() -> Bool {
        currentCharacter.A1isActive() == true
    }
    
    func isAction2Active() -> Bool {
        currentCharacter.A2isActive() == true
    }
    
    func isAction3Active() -> Bool {
        currentCharacter.A3isActive() == true
    }
    
    func isAction4Active() -> Bool {
        currentCharacter.A4isActive() == true
    }
    
    func isUsable1Active() -> Bool {
        currentCharacter.U1isActive() == true
    }
    
    func isUsable2Active() -> Bool {
        currentCharacter.U2isActive() == true
    }
    func addActions() {
        if isAction1Active() == true {
            action1 = currentCharacter.returnAction1()
            WeaponAction1LabelText = action1?.Name
        }
        
        if isAction2Active() == true {
            action2 = currentCharacter.returnAction2()
            WeaponAction2LabelText = action2?.Name
        }
        
        if isAction3Active() == true {
            action3 = currentCharacter.returnAction3()
            NormalAction1LabelText = action3?.Name
        }
        
        if isAction4Active() == true {
            action4 = currentCharacter.returnAction4()
            NormalAction2LabelText = action4?.Name
        }
        
        if isUsable1Active() == true {
            if currentCharacter.returnInventoryItem(slot: 5).PotionActive == true ||
                currentCharacter.returnInventoryItem(slot: 5).DamageActive == true {
                action5 = currentCharacter.returnUsableAction1()
                UsableAction1LabelText = action5?.Name
            }
        }
        
        if isUsable1Active() == true {
            if currentCharacter.returnInventoryItem(slot: 6).PotionActive == true ||
                currentCharacter.returnInventoryItem(slot: 6).DamageActive == true {
                action6 = currentCharacter.returnUsableAction2()
                UsableAction2LabelText = action6?.Name
            }
        }
    }
    
    func roll(Mod: Int) -> Int {
        var roll =  Int.random(in: 1...20)
        roll = roll + Mod
        print(roll)
        return roll
    }
    
    
    //Switch not working as i expected seperate this is basically the same code 6 times
    
    @IBAction func actionButtonPressed(button: Int) {
        aB.playButtonSound("buttonClicked")
        isPlayerTurn = false
        if button == 1 || button == 2 ||
            (button == 3 && action3!.isDamageAction == true) ||
            (button == 4 && action4!.isDamageAction == true) ||
            (button == 5 && action5!.isDamageAction == true) ||
            (button == 6 && action6!.isDamageAction == true) {
            
            attackRoll = roll(Mod: currentCharacter.returnAttackMod())
            if didAttackHit() {
                var newHP = 0
                switch button {
                case 1:
                    newHP = currentEnemy!.CurrentHitPoints - action1!.Damage
                    DiceOutcomeLabelText = "Your Attack Roll Hit and Dealt \(action1!.Damage) Damage to The \(currentEnemy!.Name)"
                case 2:
                    newHP = currentEnemy!.CurrentHitPoints - action2!.Damage
                    DiceOutcomeLabelText = "Your Attack Roll Hit and Dealt \(action2!.Damage) Damage to The \(currentEnemy!.Name)"
                case 3:
                    newHP = currentEnemy!.CurrentHitPoints - action3!.Damage
                    DiceOutcomeLabelText = "Your Attack Roll Hit and Dealt \(action3!.Damage) Damage to The \(currentEnemy!.Name)"
                case 4:
                    newHP = currentEnemy!.CurrentHitPoints - action4!.Damage
                    DiceOutcomeLabelText = "Your Attack Roll Hit and Dealt \(action4!.Damage) Damage to The \(currentEnemy!.Name)"
                case 5:
                    newHP = currentEnemy!.CurrentHitPoints - action5!.Damage
                    DiceOutcomeLabelText = "Your Attack Roll Hit and Dealt \(action5!.Damage) Damage to The \(currentEnemy!.Name)"
                case 6:
                    newHP = currentEnemy!.CurrentHitPoints - action6!.Damage
                    DiceOutcomeLabelText = "Your Attack Roll Hit and Dealt \(action6!.Damage) Damage to The \(currentEnemy!.Name)"
                default:
                    print("error")
                }
                updateEnemyHP(newHP: newHP)
            } else {
                DiceOutcomeLabelText = "Your Attack Roll Missed"
            }
            D20LabelText = "\(attackRoll)"
            
        } else {
            switch button {
            case 3:
                currentCharacter.changeHP(amount: action3!.HitPoints)
            case 4:
                currentCharacter.changeHP(amount: action4!.HitPoints)
            case 5:
                currentCharacter.changeHP(amount: action5!.HitPoints)
            case 6:
                currentCharacter.changeHP(amount: action6!.HitPoints)
            default:
                print("error")
            }
        }
        
    }
    
    func checkDamageAction(action: Int) -> Bool {
        switch action {
        case 3:
            return action3!.isDamageAction == true
        case 4:
            return action4!.isDamageAction == true
        case 5:
            return action5!.isDamageAction == true
        case 6:
            return action6!.isDamageAction == true
        default:
            print("error")
        }
        return false
    }
    
    func checkBuffAction(action: Int) -> Bool {
        switch action {
        case 3:
            return action3!.isBuffAction == true
        case 4:
            return action4!.isBuffAction == true
        case 5:
            return action5!.isBuffAction == true
        case 6:
            return action6!.isBuffAction == true
        default:
            print("error")
        }
        return false
    }
    
    func playButtonSound() {
        aB.playButtonSound("buttonClicked")
    }
    
    func checkEnemyHp() -> Bool {
        currentEnemy!.CurrentHitPoints > 0
    }
    
    func didAttackHit() -> Bool {
        attackRoll >= currentCharacter.returnAC()
    }
    
    func didCharacterDie() -> Bool {
        currentCharacter.tempHP() <= 0
    }
    
    func rollForAttack() {
        attackRoll = roll(Mod: currentEnemy!.AttackMod)
    }
    
    func attackAction() {
        let newHP = 0 - currentEnemy!.actions.first!.Damage
        currentCharacter.changeHP(amount: newHP)
        DiceOutcomeLabelText = "The \(currentEnemy!.Name) Attack Hit and Dealt \(currentEnemy!.actions.first!.Damage) Damage to You"
    }
    
    func missedAttack() {
        DiceOutcomeLabelText = "The \(currentEnemy!.Name) Attack Roll Missed"
    }
    
    func attackEnd() {
        D20LabelText = "\(attackRoll)"
        isPlayerTurn = true
    }
    
    func enemyIsDead() {
        gameLogic.saveGame(save: gameLogic.nextStoryTabString!)
        aB.stopVoice()
        aB.playVoiceSound(gameLogic.nextStoryTabString!)
    }
    
    func ifCharacterDied() {
        currentCharacter.resetHP()
        gameLogic.storyTabToReturn = gameLogic.getCurrentST().StoryTabID
        gameLogic.saveGame(save: gameLogic.storyTabToReturn!)
    }
    
}
