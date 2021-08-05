//
//  ItemViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation

class ItemViewModel {

    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentCharacter = characterBrain.characterInstance
    
    var itemRoomDiscriptionText: String?
    var itemRoomOptionLabelText: String?
    var ItemsLabelText: String?
    
    init() {
        gameLogic.initGame()
        currentCharacter.initCharacter()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView(){
        itemRoomDiscriptionText = gameLogic.getCurrentST().StoryTabDiscription
        itemRoomOptionLabelText = gameLogic.getCurrentST().StoryTabMoveDiscription1
        var itemString = ""
        for item in gameLogic.getCurrentST().items {
            itemString = itemString + item.Name + "\n"
        }
        ItemsLabelText = itemString
    }
    
    func playButtonSound() {
        aB.playButtonSound("buttonClicked")
    }
    
    func moveButtonPressed() {
        playButtonSound()
        for item in gameLogic.getCurrentST().items {
            currentCharacter.addItem(item: item)
        }
        gameLogic.saveGame(save: gameLogic.getCurrentST().StoryTabMoveID1)
    }
    
}
