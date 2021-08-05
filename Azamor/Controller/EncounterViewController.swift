//
//  EncounterViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift
import AVFoundation

class EncounterViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    var encounterViewModel = EncounterViewModel()
    
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var PlayerCharacterPortait: UIImageView!
    @IBOutlet weak var EnemyImage: UIImageView!
    @IBOutlet weak var DiceImage: UIImageView!
    @IBOutlet weak var EncounterTitleLabel: UILabel!
    @IBOutlet weak var PlayerHPLabel: UILabel!
    @IBOutlet weak var PlayerArmorLabel: UILabel!
    @IBOutlet weak var PlayerAttackLabel: UILabel!
    @IBOutlet weak var EnemyHPLabel: UILabel!
    @IBOutlet weak var EnemyArmorLabel: UILabel!
    @IBOutlet weak var EnemyAttackLabel: UILabel!
    @IBOutlet weak var EnemyDamageLabel: UILabel!
    @IBOutlet weak var EnemyNameLabel: UILabel!
    @IBOutlet weak var PlayerNameLabel: UILabel!
    @IBOutlet weak var DiceOutcomeLabel: UILabel!
    
    
    @IBOutlet weak var Weapon1Back: UIImageView!
    @IBOutlet weak var Weapon2Back: UIImageView!
    @IBOutlet weak var Normal1Back: UIImageView!
    @IBOutlet weak var Normal2Back: UIImageView!
    @IBOutlet weak var Usable1Back: UIImageView!
    @IBOutlet weak var Usable2Back: UIImageView!
    @IBOutlet weak var ReturnBack: UIImageView!
    @IBOutlet weak var DiceOverlay: UIImageView!
    
    @IBOutlet weak var WeaponAction1Label: UILabel!
    @IBOutlet weak var WeaponAction2Label: UILabel!
    @IBOutlet weak var NormalAction1Label: UILabel!
    @IBOutlet weak var NormalAction2Label: UILabel!
    @IBOutlet weak var UsableAction1Label: UILabel!
    @IBOutlet weak var UsableAction2Label: UILabel!
    
    @IBOutlet weak var WeaponAction1Button: UIButton!
    @IBOutlet weak var WeaponAction2Button: UIButton!
    @IBOutlet weak var NormalAction1Button: UIButton!
    @IBOutlet weak var NormalAction2Button: UIButton!
    @IBOutlet weak var UsableAction1Button: UIButton!
    @IBOutlet weak var UsableAction2Button: UIButton!
    
    @IBOutlet weak var InventoryButton: UIButton!
    
    @IBOutlet weak var D20Label: UILabel!
    @IBOutlet weak var ReturnButton: UIButton!
    @IBOutlet weak var ReturnLabel: UILabel!
    
    var isReturnedFromInventory = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if isReturnedFromInventory == false {
            encounterViewModel.setEnemyHP()
        }
        else {
            isReturnedFromInventory = false
        }
        addActions()
        initView()
        //initBackgroundMusic()
    }
    
    func initView() {
        encounterViewModel.initView()
        if encounterViewModel.EnemyImageString != "" {
            EnemyImage.image = UIImage(named: encounterViewModel.EnemyImageString!)
        }
        PlayerCharacterPortait.image = UIImage(named: encounterViewModel.characterImageString!)
        BackgroundImage.image = UIImage(named: encounterViewModel.StoryTabBackgroundImageString!)
        EncounterTitleLabel.text = encounterViewModel.StoryTabDiscription!
        PlayerHPLabel.text = "HP: \(String(describing: encounterViewModel.tempHP!))"
        PlayerArmorLabel.text = "Armor: \(String(describing: encounterViewModel.returnAC!))"
        PlayerAttackLabel.text = "Attack: \(String(describing: encounterViewModel.returnAttackMod!))"
        
        EnemyHPLabel.text = "HP: \(String(describing: encounterViewModel.CurrentHitPoints!))"
        EnemyArmorLabel.text = "Armor: \(String(describing: encounterViewModel.AC!))"
        EnemyAttackLabel.text = "Attack: \(String(describing: encounterViewModel.AttackMod!))"
        EnemyDamageLabel.text = "Damage: \(String(describing: encounterViewModel.Damage!))"
        EnemyNameLabel.text = "\(String(describing: encounterViewModel.Name!))"
        PlayerNameLabel.text = encounterViewModel.Name
    }
    
    // if else if else if else i need to refactor this big time
    
    func addActions() {
        
        if encounterViewModel.isAction1Active(){
            WeaponAction1Label.text = encounterViewModel.WeaponAction1LabelText
        } else {
            WeaponAction1Label.isHidden = true
            WeaponAction1Button.isHidden = true
            Weapon1Back.isHidden = true
        }
        
        if encounterViewModel.isAction2Active() {
            WeaponAction2Label.text = encounterViewModel.WeaponAction2LabelText
            
        } else {
            WeaponAction2Label.isHidden = true
            WeaponAction2Button.isHidden = true
            Weapon2Back.isHidden = true
        }
        
        if encounterViewModel.isAction3Active(){
            NormalAction1Label.text = encounterViewModel.NormalAction1LabelText
        } else {
            NormalAction1Label.isHidden = true
            NormalAction1Button.isHidden = true
            Normal1Back.isHidden = true
        }
        
        if encounterViewModel.isAction4Active() {
            NormalAction2Label.text = encounterViewModel.NormalAction2LabelText
        } else {
            NormalAction2Label.isHidden = true
            NormalAction2Button.isHidden = true
            Normal2Back.isHidden = true
        }
        
        if encounterViewModel.isUsable1Active() {
            UsableAction1Label.text = encounterViewModel.UsableAction1LabelText
        } else {
            UsableAction1Label.isHidden = true
            UsableAction1Button.isHidden = true
            Usable1Back.isHidden = true
        }
        
        if encounterViewModel.isUsable2Active() {
            UsableAction2Label.text = encounterViewModel.UsableAction2LabelText
            
        } else {
            UsableAction2Label.isHidden = true
            UsableAction2Button.isHidden = true
            Usable2Back.isHidden = true
        }
    }
    
    //dice show/hide functions
    
    func showDice(){
        ReturnBack.isHidden = false
        ReturnButton.isHidden = false
        DiceOverlay.isHidden = false
        DiceImage.isHidden = false
        D20Label.isHidden = false
        DiceOutcomeLabel.isHidden = false
        ReturnLabel.isHidden = false
        
        WeaponAction1Button.isEnabled = false
        WeaponAction2Button.isEnabled = false
        NormalAction1Button.isEnabled = false
        NormalAction2Button.isEnabled = false
        UsableAction1Button.isEnabled = false
        UsableAction2Button.isEnabled = false
        
        InventoryButton.isEnabled = false
    }
    
    func hideDice(){
        ReturnBack.isHidden = true
        ReturnButton.isHidden = true
        DiceOverlay.isHidden = true
        DiceImage.isHidden = true
        D20Label.isHidden = true
        DiceOutcomeLabel.isHidden = true
        ReturnLabel.isHidden = true
        
        WeaponAction1Button.isEnabled = true
        WeaponAction2Button.isEnabled = true
        NormalAction1Button.isEnabled = true
        NormalAction2Button.isEnabled = true
        UsableAction1Button.isEnabled = true
        UsableAction2Button.isEnabled = true
        
        InventoryButton.isEnabled = true
    }
    
    //Switch not working as i expected seperate this is basically the same code 6 times
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        encounterViewModel.playButtonSound()
        encounterViewModel.actionButtonPressed(button: sender.tag)
        
        if sender.tag == 1 || sender.tag == 2 {
            if encounterViewModel.didAttackHit() {
                DiceOutcomeLabel.text = encounterViewModel.DiceOutcomeLabelText
            } else {
                DiceOutcomeLabel.text = "Your Attack Roll Missed"
            }
            D20Label.text = encounterViewModel.D20LabelText
            showDice()
        } else {
            if encounterViewModel.checkDamageAction(action: sender.tag) {
                if encounterViewModel.didAttackHit() {
                    DiceOutcomeLabel.text = encounterViewModel.DiceOutcomeLabelText
                } else {
                    DiceOutcomeLabel.text = "Your Attack Roll Missed"
                }
                D20Label.text = encounterViewModel.D20LabelText
                showDice()
            } else if encounterViewModel.checkBuffAction(action: sender.tag) {
                showDice()
                returnFunction()
            }
        }
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        encounterViewModel.playButtonSound()
        coordinator?.encounterToInventory(vc: self)
    }
    
    func returnFunction() {
        if encounterViewModel.isPlayerTurn == false {
            if encounterViewModel.checkEnemyHp() {
                encounterViewModel.rollForAttack()
                
                if encounterViewModel.didAttackHit() {
                    encounterViewModel.attackAction()
                    DiceOutcomeLabel.text = encounterViewModel.DiceOutcomeLabelText
                }
                else {
                    encounterViewModel.missedAttack()
                    DiceOutcomeLabel.text = encounterViewModel.DiceOutcomeLabelText
                }
                encounterViewModel.attackEnd()
                D20Label.text = encounterViewModel.D20LabelText
            } else {
                encounterViewModel.enemyIsDead()
                coordinator?.encounterToStory(vc: self)
            }
        } else {
            if encounterViewModel.didCharacterDie(){
                encounterViewModel.ifCharacterDied()
                coordinator?.encounterToStory(vc: self)
            } 
            hideDice()
        }
        initView()
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        encounterViewModel.playButtonSound()
        returnFunction()
    }
    
}
