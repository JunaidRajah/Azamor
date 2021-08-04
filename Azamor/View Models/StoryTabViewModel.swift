//
//  StoryTabViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/30.
//

//import Foundation
//import RealmSwift
//
//class StoryTabViewModel {
//
//    var gameLogic = gameBrain()
//    var currentCharacter = characterBrain()
//
//    init() {
//        gameLogic.initGame()
//        currentCharacter.initCharacter()
//    }
//
//    func checkNextRoom() -> Int {
//        let Story = gameLogic.nextStoryTab!
//        if Story.isEncounter == true {
//            return 1
//        }
//        if Story.isItemRoom == true {
//            return 2
//        }
//        return 0
//    }
//
//    func checkFromRoom() -> Int {
//        let Story = gameLogic.getCurrentST()
//        gameLogic.checkFromRoom(Story: Story)
//        if Story.isEncounter == true {
//            return 1
//        }
//        if Story.isItemRoom == true {
//            return 2
//        }
//        return 0
//    }
//}
