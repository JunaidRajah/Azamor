//
//  DiceViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/06.
//

import UIKit
import RealmSwift
import AVFoundation

class DiceViewController: UIViewController {

    let realm = try! Realm()
    var aB = audioBrain()
    var gameLogic = gameBrain()
    
    @IBOutlet weak var RollTypeLabel: UILabel!
    @IBOutlet weak var DCLabel: UILabel!
    @IBOutlet weak var AttemptsLabel: UILabel!
    @IBOutlet weak var DiceNumber: UILabel!
    @IBOutlet weak var RollButton: UIButton!
    @IBOutlet weak var ReturnButton: UIButton!
    
    
    
    var currentTrack: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshDiceView()
        // Do any additional setup after loading the view.
    }
        
        func refreshDiceView(){
            aB.stopVoice()
            RollTypeLabel.text = "\(gameLogic.currentType ?? "error") Roll"
            DCLabel.text = "DC To Beat: \(gameLogic.currentDC ?? -1)"
            AttemptsLabel.text = "You have \(gameLogic.currentAttempts ?? -1) attempts remaining"
            DiceNumber.text = "\(gameLogic.currentRoll)"
        }
        
        @IBAction func rollButtonPressed(_ sender: UIButton) {
            aB.playButtonSound("buttonClicked")
            var roll =  Int.random(in: 1...20)
            roll = roll + gameLogic.currentMod!
            gameLogic.currentRoll = roll

            if roll >= gameLogic.currentDC! {
                gameLogic.currentAttempts! = gameLogic.currentAttempts! - 1
                gameLogic.storyTabToReturn = gameLogic.nextStoryTabString!
                RollButton.isHidden = true
                ReturnButton.isHidden = false
                refreshDiceView()
                AttemptsLabel.text = "You Are Successful!"
                print("Dice ST to return successful attempt")
                print(gameLogic.storyTabToReturn!)
            } else {
                gameLogic.currentAttempts! = gameLogic.currentAttempts! - 1
                refreshDiceView()
                if gameLogic.currentAttempts == 0 {
                    RollButton.isHidden = true
                    ReturnButton.isHidden = false
                    refreshDiceView() as Any
                    AttemptsLabel.text = "You Failed Your Ability Check!"
                    gameLogic.storyTabToReturn = gameLogic.getCurrentST().StoryTabID
                    print("Dice ST to return failed attempt")
                    print(gameLogic.storyTabToReturn!)
                }
            }
            
            
        }
        
        @IBAction func returnButtonPressed(_ sender: UIButton) {
            aB.playButtonSound("buttonClicked")
            gameLogic.saveGame(save: gameLogic.storyTabToReturn!)
            performSegue(withIdentifier: "diceToStory", sender: self)
        }
        
        func resetDice() {
            gameLogic.currentType = ""
            gameLogic.currentDC = 0
            gameLogic.currentMod = 0
            gameLogic.currentRoll = 0
            gameLogic.currentAttempts = 0

        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "diceToStory" {
                let destinationVC = segue.destination as! StoryTabViewController
                destinationVC.gameLogic = gameLogic
                destinationVC.currentTrack = currentTrack
                destinationVC.aB = aB
            }
        }
    
}
