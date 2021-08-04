//
//  gameBrain.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/16.
//

import Foundation
import RealmSwift

class gameBrain {
    //still has to be implemented
    static let gameInstance = gameBrain()
    let realm = try! Realm()
    
    var currentGame: Game?
    var Games: Results<Game>?
    var storyTabs: Results<StoryTab>?
    var pred: String?
    private var currentStoryTab: StoryTab?
    var currentStoryTabString: String?
    
    var nextStoryTab:StoryTab?
    var nextStoryTabString: String?
    var storyTabToReturn: String?
    
    var currentType: String?
    var currentDC: Int?
    var currentMod: Int?
    var currentAttempts: Int?
    var currentRoll = 0
    
    var currentEnemy: Enemy?
    var EncounterItems: List<Item>?
    var action1: Action?
    var action2: Action?
    var action3: Action?
    var action4: Action?
    var action5: Action?
    var action6: Action?
    
    var currentCharacter = characterBrain.characterInstance
    
    var roomItems: List<Item>?
    
    var itemListToSend: Results<Item>?
    
    var itemList: Results<Item>?
    
    var currentBackgroundString = ""
    
    let storyStart = ["S01a","S01b","S01c","S01d","S01e","S01f",
                      "S01g","S01h","S01i","S01j","S01k","S01l",
                      "S01m","S01n","S01oE","S01p","S02a","S02b","S02c"]
    
    func initGame() {
        Games = realm.objects(Game.self)
        currentGame = Games!.first
        currentCharacter.initCharacter()
        
        storyTabs = realm.objects(StoryTab.self)
        
        pred = "StoryTabID = '\(String(describing: currentGame!.CurrentStoryTab))'"
        currentStoryTab = storyTabs!.filter(pred!).first
        currentStoryTabString = currentStoryTab!.StoryTabID
        currentBackgroundString = currentStoryTab!.StoryTabBackgroundImageString
    }
    
    func checkIfStartingCharIsActive() -> Bool {
        if storyStart.contains(currentStoryTabString!) {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentST() ->  StoryTab{
        return currentStoryTab!
    }
    
    func optionButtonAction(button: Int) -> Bool{
        switch button {
        case 1:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabMoveID1))'"
            nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabMoveRequiresRoll1 == true) {
                currentType = currentStoryTab?.StoryTabMoveType1
                currentDC = currentStoryTab?.StoryTabMoveDC1 ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabMoveID1
                return true
            } else {
                
                do {
                    let game = realm.objects(Game.self).first!
                    try realm.write {
                        print(currentStoryTab!.StoryTabMoveID1)
                        game.setValue(currentStoryTab!.StoryTabMoveID1, forKey: "CurrentStoryTab")
                    }
                } catch  {
                    print(error)
                }
                nextStoryTabString = nextStoryTab?.StoryTabID
                currentStoryTab = nextStoryTab
                currentStoryTabString = currentStoryTab?.StoryTabID
                return false
            }
        case 2:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabMoveID2))'"
            nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabMoveRequiresRoll2 == true) {
                currentType = currentStoryTab?.StoryTabMoveType2
                currentDC = currentStoryTab?.StoryTabMoveDC2 ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabMoveID2
                return true
            } else {
                do {
                    let game = realm.objects(Game.self).first!
                    try realm.write {
                        print(currentStoryTab!.StoryTabMoveID2)
                        game.setValue(currentStoryTab!.StoryTabMoveID2, forKey: "CurrentStoryTab")
                    }
                } catch  {
                    print(error)
                }
                nextStoryTabString = nextStoryTab?.StoryTabID
                currentStoryTab = nextStoryTab
                currentStoryTabString = currentStoryTab?.StoryTabID
                return false
            }
            
        case 3:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabMoveID3))'"
            nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabMoveRequiresRoll3 == true) {
                currentType = currentStoryTab?.StoryTabMoveType3
                currentDC = currentStoryTab?.StoryTabMoveDC3 ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabMoveID3
                return true

            } else {
                do {
                    let game = realm.objects(Game.self).first!
                    try realm.write {
                        print(currentStoryTab!.StoryTabMoveID3)
                        game.setValue(currentStoryTab!.StoryTabMoveID3, forKey: "CurrentStoryTab")
                    }
                } catch  {
                    print(error)
                }
                nextStoryTabString = nextStoryTab?.StoryTabID
                currentStoryTab = nextStoryTab
                currentStoryTabString = currentStoryTab?.StoryTabID
                return false
            }
            
        case 4:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabMoveID4))'"
            nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabMoveRequiresRoll4 == true) {
                currentType = currentStoryTab?.StoryTabMoveType4
                currentDC = currentStoryTab?.StoryTabMoveDC4 ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabMoveID4
                return true

            } else {
                do {
                    let game = realm.objects(Game.self).first!
                    try realm.write {
                        print(currentStoryTab!.StoryTabMoveID4)
                        game.setValue(currentStoryTab!.StoryTabMoveID4, forKey: "CurrentStoryTab")
                    }
                } catch  {
                    print(error)
                }
                nextStoryTabString = nextStoryTab?.StoryTabID
                currentStoryTab = nextStoryTab
                currentStoryTabString = currentStoryTab?.StoryTabID
                return false
            }
            
        case 5:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabBackID))'"
            nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabBackRequiresRoll == true) {
                currentType = currentStoryTab?.StoryTabBackType1
                currentDC = currentStoryTab?.StoryTabBackDC ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabBackID
                return true

            } else {
                do {
                    let game = realm.objects(Game.self).first!
                    try realm.write {
                        print(currentStoryTab!.StoryTabBackID)
                        game.setValue(currentStoryTab!.StoryTabBackID, forKey: "CurrentStoryTab")
                    }
                } catch  {
                    print(error)
                }
                nextStoryTabString = nextStoryTab?.StoryTabID
                currentStoryTab = nextStoryTab
                currentStoryTabString = currentStoryTab?.StoryTabID
                return false
            }
            
        case 6:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabFowardID))'"
            nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabFowardRequiresRoll == true) {
                currentType = currentStoryTab?.StoryTabFowardType
                currentDC = currentStoryTab?.StoryTabFowardDC ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabFowardID
                return true

            } else {
                do {
                    let game = realm.objects(Game.self).first!
                    try realm.write {
                        print(currentStoryTab!.StoryTabFowardID)
                        game.setValue(currentStoryTab!.StoryTabFowardID, forKey: "CurrentStoryTab")
                    }
                } catch  {
                    print(error)
                }
                nextStoryTabString = nextStoryTab?.StoryTabID
                currentStoryTab = nextStoryTab
                currentStoryTabString = currentStoryTab?.StoryTabID
                return false
            }

        default:
            let pred = "StoryTabID = 'S01a'"
            currentStoryTab = storyTabs?.filter(pred).first
            return false
        }
    }
    
    func checkFromRoom(Story: StoryTab){
        if Story.isEncounter == true {
            nextStoryTabString = currentStoryTab!.StoryTabID
        }
    }
    
    func returnCorrectStatMod(stat: String) -> Int {
        var mod = 0
        switch stat {
        case "Strength":
            mod = currentCharacter.returnStrengthMod()
        case "Dexterity":
            mod = currentCharacter.returnDexterityMod()
        case "Constitution":
            mod = currentCharacter.returnConstitutionMod()
        case "Wisdom":
            mod = currentCharacter.returnWisdomMod()
        case "Intelligence":
            mod = currentCharacter.returnIntelligenceMod()
        case "Charisma":
            mod = currentCharacter.returnCharismaMod()
        default:
            mod = 0
        }
        print(mod)
        return mod
    }
    
    func saveGame(save: String) {
        do {
            try realm.write {
                currentGame!.setValue(save, forKey: "CurrentStoryTab")
            }
        } catch  {
            print(error)
        }
    }
    
    func saveCurrentGame() {
        do {
            try realm.write {
                currentGame!.setValue(currentStoryTab!.StoryTabID, forKey: "CurrentStoryTab")
            }
        } catch  {
            print(error)
        }
    }
    
    func changeCharacter(index: Int) {
        if index == 1 {
            do {
                let raziel = realm.objects(PlayerCharacter.self)[0]
                try realm.write {
                    currentGame!.setValue(raziel, forKey: "GamePlayerCharacter")
                }
            } catch  {
                print(error)
            }
        }
        else if index == 2 {
            do {
                let razaila = realm.objects(PlayerCharacter.self)[1]
                try realm.write {
                    currentGame!.setValue(razaila, forKey: "GamePlayerCharacter")
                }
            } catch  {
                print(error)
            }
        }
    }
}
