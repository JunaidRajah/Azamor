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
    
    @IBOutlet weak var RollTypeLabel: UILabel!
    @IBOutlet weak var DCLabel: UILabel!
    @IBOutlet weak var AttemptsLabel: UILabel!
    @IBOutlet weak var DiceNumber: UILabel!
    @IBOutlet weak var RollButton: UIButton!
    @IBOutlet weak var ReturnButton: UIButton!
    
    
    var currentType: String?
    var currentDC: Int?
    var currentMod: Int?
    var currentRoll = 0
    var currentAttempts: Int?
    var currentStoryTab: String?
    var nextStoryTab: String?
    var storyTabToReturn: String?
    var currentTrack: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshDiceView()
        // Do any additional setup after loading the view.
    }
        
        func refreshDiceView(){
            aB.stopVoice()
            RollTypeLabel.text = "\(currentType ?? "error") Roll"
            DCLabel.text = "DC To Beat: \(currentDC ?? -1)"
            AttemptsLabel.text = "You have \(currentAttempts ?? -1) attempts remaining"
            DiceNumber.text = "\(currentRoll)"
        }
        
        @IBAction func rollButtonPressed(_ sender: UIButton) {
            aB.playButtonSound("buttonClicked")
            var roll =  Int.random(in: 1...20)
            roll = roll + currentMod!
            currentRoll = roll

            if roll >= currentDC! {
                currentAttempts! = currentAttempts! - 1
                storyTabToReturn = nextStoryTab
                RollButton.isHidden = true
                ReturnButton.isHidden = false
                refreshDiceView()
                AttemptsLabel.text = "You Are Successful!"
            } else {
                currentAttempts! = currentAttempts! - 1
                refreshDiceView()
                if currentAttempts == 0 {
                    RollButton.isHidden = true
                    ReturnButton.isHidden = false
                    refreshDiceView()
                    AttemptsLabel.text = "You Failed Your Ability Check!"
                    storyTabToReturn = currentStoryTab
                }
            }
            
            
        }
        
        @IBAction func returnButtonPressed(_ sender: UIButton) {
            aB.playButtonSound("buttonClicked")
            do {
                let game = realm.objects(Game.self).first
                try realm.write {
                    game?.setValue(storyTabToReturn, forKey: "CurrentStoryTab")
                }
            } catch  {
                print(error)
            }
            performSegue(withIdentifier: "diceToStory", sender: self)
        }
        
        func resetDice() {
            currentType = ""
            currentDC = 0
            currentMod = 0
            currentRoll = 0
            currentAttempts = 0

        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "diceToStory" {
                let destinationVC = segue.destination as! StoryTabViewController
                destinationVC.currentTrack = currentTrack
                destinationVC.aB = aB
            }
        }
    
}
