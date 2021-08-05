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
    var characterSelectViewModel = CharacterSelectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func moreButtonPresssed(_ sender: UIButton) {
        characterSelectViewModel.moreButtonPresssed(button: sender.tag)
        coordinator?.selectToChar(vc: self)
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        characterSelectViewModel.selectButtonPressed(button: sender.tag)
        coordinator?.selectToStory(vc: self)
    }
}
