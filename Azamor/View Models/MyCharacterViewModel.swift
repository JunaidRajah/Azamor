//
//  MyCharacterViewModel.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/04.
//

import Foundation

class MyCharacterViewModel {

    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentCharacter = characterBrain.characterInstance
    
    var nameLabelText: String?
    var hpLabelText: String?
    var acLabelText: String?
    var levelLabelText: String?
    var attackLabelText: String?
    var strLabelText: String?
    var dexLabelText: String?
    var conLabelText: String?
    var wisLabelText: String?
    var intLabelText: String?
    var chaLabelText: String?
    var charImageString: String?
    
    init() {
        currentCharacter.initCharacter()
        initView()
    }
    
    func initView() {
        nameLabelText = currentCharacter.returnName()
        hpLabelText = String(currentCharacter.maxHP())
        acLabelText = String(currentCharacter.returnAC())
        levelLabelText = String(currentCharacter.returnLevel())
        attackLabelText = String(currentCharacter.returnAttackMod())
        strLabelText = String(10 + currentCharacter.returnStrengthMod())
        dexLabelText = String(10 + currentCharacter.returnDexterityMod())
        conLabelText = String(10 + currentCharacter.returnConstitutionMod())
        wisLabelText = String(10 + currentCharacter.returnWisdomMod())
        intLabelText = String(10 + currentCharacter.returnIntelligenceMod())
        chaLabelText = String(10 + currentCharacter.returnCharismaMod())
        charImageString = currentCharacter.returnImgString()
    }
}
