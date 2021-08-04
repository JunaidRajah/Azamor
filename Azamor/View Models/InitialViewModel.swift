//
//  InitialViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation

class InitialViewModel {
    
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    
    init() {
        gameLogic.initGame()
        aB.playBackgroundSound("Start")
        aB.currentTrack = "Start"
    }
}
