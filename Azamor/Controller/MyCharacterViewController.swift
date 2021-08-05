//
//  MyCharacterViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift

class MyCharacterViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    var myCharacterViewModel = MyCharacterViewModel()
    
    var isFromMain = true

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var HpLabel: UILabel!
    @IBOutlet weak var ACLabel: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var AttackLabel: UILabel!
    @IBOutlet weak var StrLabel: UILabel!
    @IBOutlet weak var DexLabel: UILabel!
    @IBOutlet weak var ConLabel: UILabel!
    @IBOutlet weak var WisLabel: UILabel!
    @IBOutlet weak var IntLabel: UILabel!
    @IBOutlet weak var ChaLabel: UILabel!
    
    @IBOutlet weak var charImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        NameLabel.text = myCharacterViewModel.nameLabelText
        HpLabel.text = myCharacterViewModel.hpLabelText
        ACLabel.text = myCharacterViewModel.acLabelText
        LevelLabel.text = myCharacterViewModel.levelLabelText
        AttackLabel.text = myCharacterViewModel.attackLabelText
        StrLabel.text = myCharacterViewModel.strLabelText
        DexLabel.text = myCharacterViewModel.dexLabelText
        ConLabel.text = myCharacterViewModel.conLabelText
        WisLabel.text = myCharacterViewModel.wisLabelText
        IntLabel.text = myCharacterViewModel.intLabelText
        ChaLabel.text = myCharacterViewModel.chaLabelText
        
        charImage.image = UIImage(named: myCharacterViewModel.charImageString!)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if isFromMain == true {
            coordinator?.charToMain(vc: self)
        } else {
            coordinator?.charToSelect(vc: self)
        }
    }
}
