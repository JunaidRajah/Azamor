//
//  DiceViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation

class DiceViewModel {
    
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    
    var RollTypeLabelText: String?
    var DCLabelText: String?
    var AttemptsLabelText: String?
    var DiceNumberText: String?
    var roll = 1

        
    func refreshDiceView(){
        aB.stopVoice()
        RollTypeLabelText = "\(gameLogic.currentType ?? "error") Roll"
        DCLabelText = "DC To Beat: \(gameLogic.currentDC ?? -1)"
        AttemptsLabelText = "You have \(gameLogic.currentAttempts ?? -1) attempts remaining"
        DiceNumberText = "\(gameLogic.currentRoll)"
    }
    
    func checkRoll() -> Bool {
        roll >= gameLogic.currentDC!
    }
    
    func didWinRoll() {
        gameLogic.currentAttempts! = gameLogic.currentAttempts! - 1
        gameLogic.storyTabToReturn = gameLogic.nextStoryTabString!
        refreshDiceView()
        print("Dice ST to return successful attempt")
        print(gameLogic.storyTabToReturn!)
    }
    
    func didLoseRoll() {
        gameLogic.currentAttempts! = gameLogic.currentAttempts! - 1
        refreshDiceView()
    }
    
    func checkCurrentAttempts() -> Bool{
        gameLogic.currentAttempts == 0
    }
    
    func ranOutOfDiceAttempts() {
        refreshDiceView()
        gameLogic.storyTabToReturn = gameLogic.getCurrentST().StoryTabID
        print("Dice ST to return failed attempt")
        print(gameLogic.storyTabToReturn!)
    }
    
    func rollButtonPressed() {
        aB.playButtonSound("buttonClicked")
        roll =  Int.random(in: 1...20)
        roll = roll + gameLogic.currentMod!
        gameLogic.currentRoll = roll
    }
    
    func returnButtonPressed() {
        aB.playButtonSound("buttonClicked")
        gameLogic.saveGame(save: gameLogic.storyTabToReturn!)
    }
    
    func resetDice() {
        gameLogic.currentType = ""
        gameLogic.currentDC = 0
        gameLogic.currentMod = 0
        gameLogic.currentRoll = 0
        gameLogic.currentAttempts = 0

    }
}
