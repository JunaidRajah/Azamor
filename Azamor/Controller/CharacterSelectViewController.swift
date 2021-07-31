//
//  CharacterSelectViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift

class CharacterSelectViewController: UIViewController {
    
    let realm = try! Realm()
    var aB = audioBrain()
    var gameLogic = gameBrain()
    
    var currentGame: Game?
    
    var currentTrack: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGame = realm.objects(Game.self).first
        
    }
    
    @IBAction func moreButtonPresssed(_ sender: UIButton) {
        
        gameLogic.changeCharacter(index: sender.tag)
        aB.playButtonSound("buttonClicked")
        performSegue(withIdentifier: "selectToChar", sender: self)
        
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        gameLogic.changeCharacter(index: sender.tag)
        
        aB.playButtonSound("buttonClicked")
        aB.stopSoundBack()
        performSegue(withIdentifier: "selectToStory", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectToStory" {
            let destinationVC = segue.destination as! StoryTabViewController
            destinationVC.gameLogic = gameLogic
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "selectToChar" {
            let destinationVC = segue.destination as! MyCharacterViewController
            destinationVC.gameLogic = gameLogic
            destinationVC.aB = aB
            destinationVC.currentTrack = currentTrack
            destinationVC.isFromMain = false
        }
        
        
    }

}
