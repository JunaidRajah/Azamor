//
//  MainMenuViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation
import RealmSwift

class MainMenuViewModel {
    
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    
    init() {
        gameLogic.initGame()
    }
    
    func checkIfStartingCharIsActive() -> Bool{
        gameLogic.checkIfStartingCharIsActive()
    }
    
    func enterAzamorButtonPressed() {
        playButtonSound()
        let char = characterBrain.characterInstance
        char.initCharacter()
    }
    
    
    func playButtonSound() {
        aB.playButtonSound("buttonClicked")
    }
}
