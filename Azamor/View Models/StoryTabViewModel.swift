//
//  StoryTabViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/30.
//

import Foundation

class StoryTabViewModel {

    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentCharacter = characterBrain.characterInstance
    
    var currentTrack: String?
    
    var StoryTabChapterName: String?
    var StoryTabDiscription: String?
    var StoryTabBackgroundImageString: String?
    var currentStoryTabString: String?

    var StoryTabMoveActive1: Bool?
    var StoryTabMoveActive2: Bool?
    var StoryTabMoveActive3: Bool?
    var StoryTabMoveActive4: Bool?
    var StoryTabBackActive: Bool?
    var StoryTabFowardActive: Bool?

    var StoryTabMoveDiscription1: String?
    var StoryTabMoveDiscription2: String?
    var StoryTabMoveDiscription3: String?
    var StoryTabMoveDiscription4: String?
    var StoryTabBackDiscription: String?
    var StoryTabFowardDiscription: String?
    
    init() {
        gameLogic.initGame()
        currentCharacter.initCharacter()
        refreshModelDisplayVariables()
        // Do any additional setup after loading the view.
    }
    
    func refreshModelDisplayVariables() {
        StoryTabChapterName = gameLogic.getCurrentST().StoryTabChapterName
        StoryTabDiscription = gameLogic.getCurrentST().StoryTabDiscription
        StoryTabBackgroundImageString = gameLogic.getCurrentST().StoryTabBackgroundImageString
        currentStoryTabString = gameLogic.currentStoryTabString
    
        StoryTabMoveActive1 = gameLogic.getCurrentST().StoryTabMoveActive1
        StoryTabMoveActive2 = gameLogic.getCurrentST().StoryTabMoveActive2
        StoryTabMoveActive3 = gameLogic.getCurrentST().StoryTabMoveActive3
        StoryTabMoveActive4 = gameLogic.getCurrentST().StoryTabMoveActive4
        StoryTabBackActive = gameLogic.getCurrentST().StoryTabBackActive
        StoryTabFowardActive = gameLogic.getCurrentST().StoryTabFowardActive
    
        StoryTabMoveDiscription1 = gameLogic.getCurrentST().StoryTabMoveDiscription1
        StoryTabMoveDiscription2 = gameLogic.getCurrentST().StoryTabMoveDiscription2
        StoryTabMoveDiscription3 = gameLogic.getCurrentST().StoryTabMoveDiscription3
        StoryTabMoveDiscription4 = gameLogic.getCurrentST().StoryTabMoveDiscription4
        StoryTabBackDiscription = gameLogic.getCurrentST().StoryTabBackDiscription
        StoryTabFowardDiscription = gameLogic.getCurrentST().StoryTabFowardDiscription
    }
    
    func checkIfStartingCharIsActive() -> Bool {
        gameLogic.checkIfStartingCharIsActive()
    }
    
    func playVoiceSound() {
        aB.playVoiceSound(gameLogic.getCurrentST().StoryTabID)
    }
    
    func checkCharSelect() -> Bool{
        gameLogic.currentStoryTabString == "S02d"
    }
    
    func initBackgroundMusic(){
        let storyBack = gameLogic.getCurrentST().StoryTabMusicString
        if storyBack != aB.currentTrack {
            aB.stopSoundBack()
            aB.playBackgroundSound(storyBack)
            aB.currentTrack = storyBack
            
        }
    }
    
    func OptionButtonAction(button: Int) -> Bool {
        gameLogic.optionButtonAction(button: button)
    }
    
    func playOptionButtonSound() {
        aB.playButtonSound("pageFlip")
        aB.stopVoice()
    }
    
    func checkNextEncounter() -> Bool {
        gameLogic.nextStoryTab!.isEncounter == true
    }
    func checkNextItemRoom() -> Bool {
        gameLogic.nextStoryTab!.isItemRoom == true
    }
    
    func checkFromEncounter() -> Bool {
        gameLogic.getCurrentST().isEncounter == true
    }
    
    func checkFromItemRoom() -> Bool {
        gameLogic.getCurrentST().isItemRoom == true
    }
    
    func checkFromRoom(){
        gameLogic.checkFromRoom(Story: gameLogic.getCurrentST())
    }
    
    func checkNextRoom(){
        gameLogic.checkNextRoom(Story: gameLogic.getCurrentST())
    }
    
    func buttonPressed() {
        aB.playButtonSound("buttonClicked")
        aB.stopVoice()
    }
    
    func changeButtonPressed() {
        buttonPressed()
        gameLogic.saveCurrentGame()
    }
}
