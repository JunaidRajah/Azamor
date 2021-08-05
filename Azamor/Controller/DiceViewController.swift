//
//  DiceViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/06.
//

import UIKit
import RealmSwift
import AVFoundation

class DiceViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    var diceViewModel = DiceViewModel()
    
    @IBOutlet weak var RollTypeLabel: UILabel!
    @IBOutlet weak var DCLabel: UILabel!
    @IBOutlet weak var AttemptsLabel: UILabel!
    @IBOutlet weak var DiceNumber: UILabel!
    @IBOutlet weak var RollButton: UIButton!
    @IBOutlet weak var ReturnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshDiceView()
        // Do any additional setup after loading the view.
    }
        
    func refreshDiceView(){
        diceViewModel.refreshDiceView()
        RollTypeLabel.text = diceViewModel.RollTypeLabelText
        DCLabel.text = diceViewModel.DCLabelText
        AttemptsLabel.text = diceViewModel.AttemptsLabelText
        DiceNumber.text = diceViewModel.DiceNumberText
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        diceViewModel.rollButtonPressed()

        if diceViewModel.checkRoll(){
            diceViewModel.didWinRoll()
            RollButton.isHidden = true
            ReturnButton.isHidden = false
            refreshDiceView()
            AttemptsLabel.text = "You Are Successful!"
        } else {
            diceViewModel.didLoseRoll()
            refreshDiceView()
            if diceViewModel.checkCurrentAttempts() {
                RollButton.isHidden = true
                ReturnButton.isHidden = false
                
                AttemptsLabel.text = "You Failed Your Ability Check!"
                diceViewModel.ranOutOfDiceAttempts()
            }
        }
        
        
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        diceViewModel.returnButtonPressed()
        coordinator?.diceToStory(vc: self)
    }
}
