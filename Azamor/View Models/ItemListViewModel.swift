//
//  ItemViewListModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation

class ItemListViewModel {
    
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentCharacter = characterBrain.characterInstance
    
    var isFromMain = false
    var isFromItem = false
    var isFromEncounter = false
    var isFromStory = false
    
    var indexToChange: Int?
    
    var isPlayerTurn = false
    
    var itemListAmount: Int?
    
    var item1LabelText: String?
    var item2LabelText: String?
    var item3LabelText: String?
    var item4LabelText: String?
    var item5LabelText: String?
    var item6LabelText: String?
        
    init() {
        currentCharacter.initCharacter()
        initView()
    }
    
    func initView(){
        itemListAmount = gameLogic.itemListToSend!.count
        switch itemListAmount {
        case 0:
            item1LabelText = "No Available Items"
        case 1:
            item1LabelText = gameLogic.itemListToSend![0].Name
        case 2:
            item1LabelText = gameLogic.itemListToSend![0].Name
            item2LabelText = gameLogic.itemListToSend![1].Name
        case 3:
            item1LabelText = gameLogic.itemListToSend![0].Name
            item2LabelText = gameLogic.itemListToSend![1].Name
            item3LabelText = gameLogic.itemListToSend![2].Name
        case 4:
            item1LabelText = gameLogic.itemListToSend![0].Name
            item2LabelText = gameLogic.itemListToSend![1].Name
            item3LabelText = gameLogic.itemListToSend![2].Name
            item4LabelText = gameLogic.itemListToSend![3].Name
        case 5:
            item1LabelText = gameLogic.itemListToSend![0].Name
            item2LabelText = gameLogic.itemListToSend![1].Name
            item3LabelText = gameLogic.itemListToSend![2].Name
            item4LabelText = gameLogic.itemListToSend![3].Name
            item5LabelText = gameLogic.itemListToSend![4].Name
        default:
            item1LabelText = gameLogic.itemListToSend![0].Name
            item2LabelText = gameLogic.itemListToSend![1].Name
            item3LabelText = gameLogic.itemListToSend![2].Name
            item4LabelText = gameLogic.itemListToSend![3].Name
            item5LabelText = gameLogic.itemListToSend![4].Name
            item6LabelText = gameLogic.itemListToSend![5].Name
        }
    }
    
    func passIndexToChange(index: Int) {
        indexToChange = index
    }
    
    func updateItem(item: Item, indexToChange: Int){
        currentCharacter.equipItem(item: item, slot: indexToChange)
    }
    
    func addButtonPressed(button: Int) {
        playButtonSound()
        let index = button
        print(index)
        let itemToSave = gameLogic.itemListToSend![index]
        
        updateItem(item: itemToSave, indexToChange: indexToChange!)
        currentCharacter.initCharacter()
    }
    
    func playButtonSound() {
        aB.playButtonSound("buttonClicked")
    }
}
