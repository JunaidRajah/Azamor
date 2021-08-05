//
//  CharacterSelectViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation

class CharacterSelectViewModel {
    
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentCharacter = characterBrain.characterInstance
    
    func moreButtonPresssed(button: Int) {
        gameLogic.changeCharacter(index: button)
        aB.playButtonSound("buttonClicked")
    }
    
    func selectButtonPressed(button: Int) {
        gameLogic.changeCharacter(index: button)
        aB.playButtonSound("buttonClicked")
        aB.stopSoundBack()
    }
}
