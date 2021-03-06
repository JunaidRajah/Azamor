//
//  MyCharacterViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift

class MyCharacterViewController: UIViewController {
    
    let realm = try! Realm()
    var aB = audioBrain()
    var currentCharacter = characterBrain()
    
    var currentTrack: String?
    
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
        currentCharacter.initCharacter()
        initView()
    }
    
    func initView() {
        NameLabel.text = currentCharacter.returnName()
        HpLabel.text = String(currentCharacter.maxHP())
        ACLabel.text = String(currentCharacter.returnAC())
        LevelLabel.text = String(currentCharacter.returnLevel())
        AttackLabel.text = String(currentCharacter.returnAttackMod())
        StrLabel.text = String(10 + currentCharacter.returnStrengthMod())
        DexLabel.text = String(10 + currentCharacter.returnDexterityMod())
        ConLabel.text = String(10 + currentCharacter.returnConstitutionMod())
        WisLabel.text = String(10 + currentCharacter.returnWisdomMod())
        IntLabel.text = String(10 + currentCharacter.returnIntelligenceMod())
        ChaLabel.text = String(10 + currentCharacter.returnCharismaMod())
        
        charImage.image = UIImage(named: currentCharacter.returnImgString())
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if isFromMain == true {
            performSegue(withIdentifier: "charToMain", sender: self)
        } else {
            performSegue(withIdentifier: "charToSelect", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "charToMain" {
            let destinationVC = segue.destination as! MainMenuViewController
            destinationVC.currentTrack = currentTrack!
            destinationVC.aB = aB
        }
        if segue.identifier == "charToSelect" {
            let destinationVC = segue.destination as! CharacterSelectViewController
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
    }
    

}
