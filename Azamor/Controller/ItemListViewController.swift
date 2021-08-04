//
//  ItemListViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/08.
//

import UIKit
import RealmSwift
import AVFoundation

class ItemListViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    let realm = try! Realm()
    var aB = audioBrain()
    var gameLogic = gameBrain()
    
    @IBOutlet weak var Item1Label: UILabel!
    @IBOutlet weak var Item2Label: UILabel!
    @IBOutlet weak var Item3Label: UILabel!
    @IBOutlet weak var Item4Label: UILabel!
    @IBOutlet weak var Item5Label: UILabel!
    @IBOutlet weak var Item6Label: UILabel!
    
    @IBOutlet weak var Item1Button: UIButton!
    @IBOutlet weak var Item2Button: UIButton!
    @IBOutlet weak var Item3Button: UIButton!
    @IBOutlet weak var Item4Button: UIButton!
    @IBOutlet weak var Item5Button: UIButton!
    @IBOutlet weak var Item6Button: UIButton!
    
    var isFromMain = false
    var isFromItem = false
    var isFromEncounter = false
    var isFromStory = false
    
    var indexToChange: Int?
    
    var currentCharacter = characterBrain()
    var currentTrack: String?
    
    let charInit = characterBrain()
    
    var isPlayerTurn = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCharacter.initCharacter()
        initView()
    }
    
    func initView(){
        switch gameLogic.itemListToSend!.count {
        case 0:
            Item1Label.isHidden = false
            Item1Label.text = "No Available Items"
        case 1:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item1Label.text = gameLogic.itemListToSend![0].Name
        case 2:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item2Label.isHidden = false
            Item2Button.isHidden = false
            
            Item1Label.text = gameLogic.itemListToSend![0].Name
            Item2Label.text = gameLogic.itemListToSend![1].Name
        case 3:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item2Label.isHidden = false
            Item2Button.isHidden = false
            
            Item3Label.isHidden = false
            Item3Button.isHidden = false
            
            Item1Label.text = gameLogic.itemListToSend![0].Name
            Item2Label.text = gameLogic.itemListToSend![1].Name
            Item3Label.text = gameLogic.itemListToSend![2].Name
        case 4:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item2Label.isHidden = false
            Item2Button.isHidden = false
            
            Item3Label.isHidden = false
            Item3Button.isHidden = false
            
            Item4Label.isHidden = false
            Item4Button.isHidden = false
            
            Item1Label.text = gameLogic.itemListToSend![0].Name
            Item2Label.text = gameLogic.itemListToSend![1].Name
            Item3Label.text = gameLogic.itemListToSend![2].Name
            Item4Label.text = gameLogic.itemListToSend![3].Name
        case 5:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
        
            Item2Label.isHidden = false
            Item2Button.isHidden = false
            
            Item3Label.isHidden = false
            Item3Button.isHidden = false
            
            Item4Label.isHidden = false
            Item4Button.isHidden = false
            
            Item5Label.isHidden = false
            Item5Button.isHidden = false
            
            Item1Label.text = gameLogic.itemListToSend![0].Name
            Item2Label.text = gameLogic.itemListToSend![1].Name
            Item3Label.text = gameLogic.itemListToSend![2].Name
            Item4Label.text = gameLogic.itemListToSend![3].Name
            Item5Label.text = gameLogic.itemListToSend![4].Name
        default:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item2Label.isHidden = false
            Item2Button.isHidden = false
        
            Item3Label.isHidden = false
            Item3Button.isHidden = false
            
            Item4Label.isHidden = false
            Item4Button.isHidden = false
            
            Item5Label.isHidden = false
            Item5Button.isHidden = false
            
            Item6Label.isHidden = false
            Item6Button.isHidden = false
            
            Item1Label.text = gameLogic.itemListToSend![0].Name
            Item2Label.text = gameLogic.itemListToSend![1].Name
            Item3Label.text = gameLogic.itemListToSend![2].Name
            Item4Label.text = gameLogic.itemListToSend![3].Name
            Item5Label.text = gameLogic.itemListToSend![4].Name
            Item6Label.text = gameLogic.itemListToSend![5].Name
        }
    }
    
    func updateItem(item: Item, indexToChange: Int){
        currentCharacter.equipItem(item: item, slot: indexToChange)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        let index = sender.tag
        print(index)
        let itemToSave = gameLogic.itemListToSend![index]
        
        updateItem(item: itemToSave, indexToChange: indexToChange!)
        charInit.initCharacter()
        coordinator?.listToInventory(vc: self)
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        aB.playButtonSound("buttonClicked")
        coordinator?.listToInventory(vc: self)
    }
}
