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
    var gameLogic = gameBrain()
    var currentCharacter = characterBrain()
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLogic.initGame()
        currentCharacter.initCharacter()
        initView()
        initBackgroundMusic()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkFromRoom(Story: gameLogic.getCurrentST())
    }
    
    func initView(){
        
        if gameLogic.checkIfStartingCharIsActive() {
            inventoryButton.isHidden = true
        } else {
            inventoryButton.isHidden = false
        }
        
        aB.playVoiceSound(gameLogic.getCurrentST().StoryTabID)
        
        print(gameLogic.currentStoryTabString ?? "error getting correct tab")
        StoryTabTitleLabel.text = gameLogic.getCurrentST().StoryTabChapterName
        StoryTabDiscriptionLabel.charInterval = 0.06
        StoryTabDiscriptionLabel.text = gameLogic.getCurrentST().StoryTabDiscription
        backgroundImage.image = UIImage(named: gameLogic.getCurrentST().StoryTabBackgroundImageString)
        
        if (gameLogic.getCurrentST().StoryTabMoveActive1 == true) {
            showUI(OptionBtn: Option1Btn, OptionImage: OptionImage1, OptionLabel: OptionLabel1)
            OptionLabel1.text = gameLogic.getCurrentST().StoryTabMoveDiscription1

        } else {
            hideUI(OptionBtn: Option1Btn, OptionImage: OptionImage1, OptionLabel: OptionLabel1)
        }
        
        if (gameLogic.getCurrentST().StoryTabMoveActive2 == true) {
            showUI(OptionBtn: Option2Btn, OptionImage: OptionImage2, OptionLabel: OptionLabel2)
            OptionLabel2.text = gameLogic.getCurrentST().StoryTabMoveDiscription2
        } else {
            hideUI(OptionBtn: Option2Btn, OptionImage: OptionImage2, OptionLabel: OptionLabel2)
        }
        
        if (gameLogic.getCurrentST().StoryTabMoveActive3 == true) {
            showUI(OptionBtn: Option3Btn, OptionImage: OptionImage3, OptionLabel: OptionLabel3)
            OptionLabel3.text = gameLogic.getCurrentST().StoryTabMoveDiscription3
        } else {
            hideUI(OptionBtn: Option3Btn, OptionImage: OptionImage3, OptionLabel: OptionLabel3)
        }
        
        if (gameLogic.getCurrentST().StoryTabMoveActive4 == true) {
            showUI(OptionBtn: Option4Btn, OptionImage: OptionImage4, OptionLabel: OptionLabel4)
            OptionLabel4.text = gameLogic.getCurrentST().StoryTabMoveDiscription4
        } else {
            hideUI(OptionBtn: Option4Btn, OptionImage: OptionImage4, OptionLabel: OptionLabel4)
        }
        
        if (gameLogic.getCurrentST().StoryTabBackActive == true) {
            showUI(OptionBtn: BackOptionBtn, OptionImage: BackOptionImage, OptionLabel: BackOptionLabel)
            BackOptionLabel.text = gameLogic.getCurrentST().StoryTabBackDiscription
        } else {
            hideUI(OptionBtn: BackOptionBtn, OptionImage: BackOptionImage, OptionLabel: BackOptionLabel)
        }
        
        if (gameLogic.getCurrentST().StoryTabFowardActive == true) {
            showUI(OptionBtn: ForwardOptionBtn, OptionImage: ForwardOptionImage, OptionLabel: ForwardOptionLabel)
            ForwardOptionLabel.text = gameLogic.getCurrentST().StoryTabFowardDiscription
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
        let storyBack = gameLogic.getCurrentST().StoryTabMusicString
        if storyBack != currentTrack {
            aB.stopSoundBack()
            aB.playBackgroundSound(storyBack)
            currentTrack = storyBack
            
        }
    }
    
    @IBAction func OptionButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("pageFlip")
        aB.stopVoice()
        
        if (gameLogic.optionButtonAction(button: sender.tag)) {
            
            performSegue(withIdentifier: "storyToDice", sender: self)
        } else {
            checkNextRoom(Story: gameLogic.nextStoryTab!)
        }
        
        if gameLogic.currentStoryTabString == "S02d" {
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
        gameLogic.checkFromRoom(Story: Story)
        if Story.isEncounter == true {
            performSegue(withIdentifier: "storyToEncounter", sender: self)
        }
        if Story.isItemRoom == true {
            performSegue(withIdentifier: "storyToItems", sender: self)
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storyToDice" {
            let destinationVC = segue.destination as! DiceViewController
            destinationVC.gameLogic = gameLogic
            destinationVC.currentTrack = currentTrack

            destinationVC.aB = aB
        }
        
        if segue.identifier == "storyToEncounter" {
            let destinationVC = segue.destination as! EncounterViewController
            destinationVC.gameLogic = gameLogic
            //destinationVC.currentStoryTabString = gameLogic.nextStoryTabString!
            destinationVC.isPlayerTurn = true
            //destinationVC.storyTabToReturn = gameLogic.getCurrentST().StoryTabID
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "storyToInventory" {
            let destinationVC = segue.destination as! InventoryViewController
            destinationVC.gameLogic = gameLogic
            destinationVC.isFromStory = true
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "storyToSelect" {
            let destinationVC = segue.destination as! CharacterSelectViewController
            destinationVC.gameLogic = gameLogic
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "storyToMain" {
            let destinationVC = segue.destination as! MainMenuViewController
            destinationVC.gameLogic = gameLogic
            destinationVC.currentTrack = currentTrack!
            destinationVC.aB = aB
        }
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        aB.stopVoice()
        gameLogic.saveCurrentGame()
        performSegue(withIdentifier: "storyToInventory", sender: self)
        
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        aB.stopVoice()
        gameLogic.saveCurrentGame()
        performSegue(withIdentifier: "storyToMain", sender: self)
        
    }
    

}
