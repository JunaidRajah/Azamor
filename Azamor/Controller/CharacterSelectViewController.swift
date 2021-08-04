//
//  CharacterSelectViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift

class CharacterSelectViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
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
        coordinator?.selectToChar(vc: self)
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        gameLogic.changeCharacter(index: sender.tag)
        aB.playButtonSound("buttonClicked")
        aB.stopSoundBack()
        coordinator?.selectToStory(vc: self)
    }
}
