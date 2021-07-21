//
//  StoryTabViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/03.
//

import UIKit
import RealmSwift
import CLTypingLabel
import AVFoundation

class StoryTabViewController: UIViewController {
    
    let realm = try! Realm()
    var aB = audioBrain()
    
    var storyTabs: Results<StoryTab>?
    var Games: Results<Game>?
    var allPCs: Results<PlayerCharacter>?
    var currentStoryTab: StoryTab?
    var currentCharacter = characterBrain()
    var currentGame: Game?
    
    var currentTrack: String?

    @IBOutlet weak var StoryTabTitleLabel: UILabel!
    @IBOutlet weak var StoryTabDiscriptionLabel: CLTypingLabel!
    @IBOutlet weak var Option1Btn: UIButton!
    @IBOutlet weak var Option2Btn: UIButton!
    @IBOutlet weak var Option3Btn: UIButton!
    @IBOutlet weak var Option4Btn: UIButton!
    @IBOutlet weak var BackOptionBtn: UIButton!
    @IBOutlet weak var ForwardOptionBtn: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var OptionImage1: UIImageView!
    @IBOutlet weak var OptionImage2: UIImageView!
    @IBOutlet weak var OptionImage3: UIImageView!
    @IBOutlet weak var OptionImage4: UIImageView!
    
    @IBOutlet weak var BackOptionImage: UIImageView!
    @IBOutlet weak var ForwardOptionImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var OptionLabel1: UILabel!
    @IBOutlet weak var OptionLabel2: UILabel!
    @IBOutlet weak var OptionLabel3: UILabel!
    @IBOutlet weak var OptionLabel4: UILabel!
    
    @IBOutlet weak var BackOptionLabel: UILabel!
    @IBOutlet weak var ForwardOptionLabel: UILabel!
    
    var currentType: String?
    var currentDC: Int?
    var currentMod: Int?
    var currentAttempts: Int?
    var currentStoryTabString: String?
    var nextStoryTabString: String?
    var currentBackgroundString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentGame = realm.objects(Game.self).first
        
        storyTabs = realm.objects(StoryTab.self)
        let pred = "StoryTabID = '\(String(describing: currentGame!.CurrentStoryTab))'"
        print(pred)
        currentStoryTab = storyTabs?.filter(pred).first
        print(currentStoryTab?.StoryTabID ?? "error getting correct tab")
        
        currentCharacter.initCharacter()
        initView()
        initBackgroundMusic()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkFromRoom(Story: currentStoryTab!)
    }
    
    func initView(){
        
        if currentStoryTab!.StoryTabID == "S01a" || currentStoryTab!.StoryTabID == "S01b" || currentStoryTab!.StoryTabID == "S01c" || currentStoryTab!.StoryTabID == "S01d"
            || currentStoryTab!.StoryTabID == "S01e" || currentStoryTab!.StoryTabID == "S01f" || currentStoryTab!.StoryTabID == "S01g" || currentStoryTab!.StoryTabID == "S01h"
            || currentStoryTab!.StoryTabID == "S01i" || currentStoryTab!.StoryTabID == "S01j" || currentStoryTab!.StoryTabID == "S01k" || currentStoryTab!.StoryTabID == "S01l"
            || currentStoryTab!.StoryTabID == "S01m" || currentStoryTab!.StoryTabID == "S01n" || currentStoryTab!.StoryTabID == "S01oE" || currentStoryTab!.StoryTabID == "S01p"
            || currentStoryTab!.StoryTabID == "S02a" || currentStoryTab!.StoryTabID == "S02b" || currentStoryTab!.StoryTabID == "S02c" {
            
            inventoryButton.isHidden = true
        } else {
            inventoryButton.isHidden = false
        }
        
        aB.playVoiceSound(currentStoryTab!.StoryTabID)
        print(currentStoryTab?.StoryTabID ?? "error getting correct tab")
        StoryTabTitleLabel.text = currentStoryTab?.StoryTabChapterName
        StoryTabDiscriptionLabel.charInterval = 0.06
        StoryTabDiscriptionLabel.text = currentStoryTab?.StoryTabDiscription
        backgroundImage.image = UIImage(named: currentStoryTab!.StoryTabBackgroundImageString)
        
        if (currentStoryTab?.StoryTabMoveActive1 == true) {
            showUI(OptionBtn: Option1Btn, OptionImage: OptionImage1, OptionLabel: OptionLabel1)
            OptionLabel1.text = currentStoryTab?.StoryTabMoveDiscription1

        } else {
            hideUI(OptionBtn: Option1Btn, OptionImage: OptionImage1, OptionLabel: OptionLabel1)
        }
        
        if (currentStoryTab?.StoryTabMoveActive2 == true) {
            showUI(OptionBtn: Option2Btn, OptionImage: OptionImage2, OptionLabel: OptionLabel2)
            OptionLabel2.text = currentStoryTab?.StoryTabMoveDiscription2
        } else {
            hideUI(OptionBtn: Option2Btn, OptionImage: OptionImage2, OptionLabel: OptionLabel2)
        }
        
        if (currentStoryTab?.StoryTabMoveActive3 == true) {
            showUI(OptionBtn: Option3Btn, OptionImage: OptionImage3, OptionLabel: OptionLabel3)
            OptionLabel3.text = currentStoryTab?.StoryTabMoveDiscription3
        } else {
            hideUI(OptionBtn: Option3Btn, OptionImage: OptionImage3, OptionLabel: OptionLabel3)
        }
        
        if (currentStoryTab?.StoryTabMoveActive4 == true) {
            showUI(OptionBtn: Option4Btn, OptionImage: OptionImage4, OptionLabel: OptionLabel4)
            OptionLabel4.text = currentStoryTab?.StoryTabMoveDiscription4
        } else {
            hideUI(OptionBtn: Option4Btn, OptionImage: OptionImage4, OptionLabel: OptionLabel4)
        }
        
        if (currentStoryTab?.StoryTabBackActive == true) {
            showUI(OptionBtn: BackOptionBtn, OptionImage: BackOptionImage, OptionLabel: BackOptionLabel)
            BackOptionLabel.text = currentStoryTab?.StoryTabBackDiscription
        } else {
            hideUI(OptionBtn: BackOptionBtn, OptionImage: BackOptionImage, OptionLabel: BackOptionLabel)
        }
        
        if (currentStoryTab?.StoryTabFowardActive == true) {
            showUI(OptionBtn: ForwardOptionBtn, OptionImage: ForwardOptionImage, OptionLabel: ForwardOptionLabel)
            ForwardOptionLabel.text = currentStoryTab?.StoryTabFowardDiscription
        } else {
            hideUI(OptionBtn: ForwardOptionBtn, OptionImage: ForwardOptionImage, OptionLabel: ForwardOptionLabel)
        }
    }
    
    func showUI(OptionBtn: UIButton, OptionImage: UIImageView, OptionLabel: UILabel){
        OptionBtn.isHidden = false
        OptionImage.isHidden = false
        OptionLabel.isHidden = false
    }
    
    func hideUI(OptionBtn: UIButton, OptionImage: UIImageView, OptionLabel: UILabel){
        OptionBtn.isHidden = true
        OptionImage.isHidden = true
        OptionLabel.isHidden = true
    }
    
    func initBackgroundMusic(){
        let storyBack = currentStoryTab!.StoryTabMusicString
        if storyBack != currentTrack {
            aB.stopSoundBack()
            aB.playBackgroundSound(storyBack)
            currentTrack = storyBack
            
        }
    }
    
    @IBAction func OptionButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("pageFlip")
        aB.stopVoice()
        switch sender.tag {
        case 1:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabMoveID1))'"
            let nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabMoveRequiresRoll1 == true) {
        
                currentType = currentStoryTab?.StoryTabMoveType1
                currentDC = currentStoryTab?.StoryTabMoveDC1 ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabMoveID1
                performSegue(withIdentifier: "storyToDice", sender: self)

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
                print(nextStoryTabString!)
                checkNextRoom(Story: nextStoryTab!)
                currentStoryTab = nextStoryTab
                
            }
        case 2:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabMoveID2))'"
            let nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabMoveRequiresRoll2 == true) {
                currentType = currentStoryTab?.StoryTabMoveType2
                currentDC = currentStoryTab?.StoryTabMoveDC2 ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabMoveID2
                performSegue(withIdentifier: "storyToDice", sender: self)

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
                checkNextRoom(Story: nextStoryTab!)
                currentStoryTab = nextStoryTab
            }
            
        case 3:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabMoveID3))'"
            let nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabMoveRequiresRoll3 == true) {
                currentType = currentStoryTab?.StoryTabMoveType3
                currentDC = currentStoryTab?.StoryTabMoveDC3 ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabMoveID3
                performSegue(withIdentifier: "storyToDice", sender: self)

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
                checkNextRoom(Story: nextStoryTab!)
                currentStoryTab = nextStoryTab
            }
            
        case 4:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabMoveID4))'"
            let nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabMoveRequiresRoll4 == true) {
                currentType = currentStoryTab?.StoryTabMoveType4
                currentDC = currentStoryTab?.StoryTabMoveDC4 ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabMoveID4
                performSegue(withIdentifier: "storyToDice", sender: self)

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
                checkNextRoom(Story: nextStoryTab!)
                currentStoryTab = nextStoryTab
            }
            
        case 5:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabBackID))'"
            let nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabBackRequiresRoll == true) {
                currentType = currentStoryTab?.StoryTabBackType1
                currentDC = currentStoryTab?.StoryTabBackDC ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabBackID
                performSegue(withIdentifier: "storyToDice", sender: self)

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
                checkNextRoom(Story: nextStoryTab!)
                currentStoryTab = nextStoryTab
            }
            
        case 6:
            let pred = "StoryTabID = '\(String(describing: currentStoryTab!.StoryTabFowardID))'"
            let nextStoryTab = storyTabs?.filter(pred).first
            if (currentStoryTab?.StoryTabFowardRequiresRoll == true) {
                currentType = currentStoryTab?.StoryTabFowardType
                currentDC = currentStoryTab?.StoryTabFowardDC ?? 10
                currentMod = returnCorrectStatMod(stat: currentType ?? "Charisma")
                currentAttempts = 3
                currentStoryTabString = currentStoryTab?.StoryTabID
                nextStoryTabString = currentStoryTab!.StoryTabFowardID
                performSegue(withIdentifier: "storyToDice", sender: self)

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
                checkNextRoom(Story: nextStoryTab!)
                currentStoryTab = nextStoryTab
            }

        default:
            let pred = "StoryTabID = 'S01a'"
            currentStoryTab = storyTabs?.filter(pred).first
            
        }
        if currentStoryTab!.StoryTabID == "S02d" {
            performSegue(withIdentifier: "storyToSelect", sender: self)
        }
        initBackgroundMusic()
        initView()
    }
    
    
    
    func checkNextRoom(Story: StoryTab){
        if Story.isEncounter == true {
            performSegue(withIdentifier: "storyToEncounter", sender: self)
        }
        if Story.isItemRoom == true {
            performSegue(withIdentifier: "storyToItems", sender: self)
        }
    }
    
    func checkFromRoom(Story: StoryTab){
        if Story.isEncounter == true {
            nextStoryTabString = currentStoryTab!.StoryTabID
            performSegue(withIdentifier: "storyToEncounter", sender: self)
        }
        if Story.isItemRoom == true {
            performSegue(withIdentifier: "storyToItems", sender: self)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storyToDice" {
            let destinationVC = segue.destination as! DiceViewController
            destinationVC.currentTrack = currentTrack
            destinationVC.currentType = currentType
            destinationVC.currentDC = currentDC
            destinationVC.currentMod = currentMod
            destinationVC.currentAttempts = currentAttempts
            destinationVC.currentStoryTab = currentStoryTabString
            destinationVC.nextStoryTab = nextStoryTabString
            destinationVC.aB = aB
        }
        
        if segue.identifier == "storyToEncounter" {
            let destinationVC = segue.destination as! EncounterViewController
            destinationVC.currentStoryTabString = nextStoryTabString!
            destinationVC.isPlayerTurn = true
            destinationVC.storyTabToReturn = currentStoryTab!.StoryTabID
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "storyToInventory" {
            let destinationVC = segue.destination as! InventoryViewController
            destinationVC.isFromStory = true
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "storyToSelect" {
            let destinationVC = segue.destination as! CharacterSelectViewController
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "storyToMain" {
            let destinationVC = segue.destination as! MainMenuViewController
            destinationVC.currentTrack = currentTrack!
            destinationVC.aB = aB
        }
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        aB.stopVoice()
            do {
                try realm.write {
                    currentGame!.setValue(currentStoryTab!.StoryTabID, forKey: "CurrentStoryTab")
                }
            } catch  {
                print(error)
            }
        performSegue(withIdentifier: "storyToInventory", sender: self)
        
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        aB.stopVoice()
        do {
            try realm.write {
                currentGame!.setValue(currentStoryTab!.StoryTabID, forKey: "CurrentStoryTab")
            }
        } catch  {
            print(error)
        }
        performSegue(withIdentifier: "storyToMain", sender: self)
        
    }
    

}
