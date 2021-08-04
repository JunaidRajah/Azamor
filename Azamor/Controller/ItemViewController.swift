//
//  ItemViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift
import AVFoundation

class ItemViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    let realm = try! Realm()
    var aB = audioBrain()
    var gameLogic = gameBrain()
    
    @IBOutlet weak var ItemRoomDiscription: UILabel!
    @IBOutlet weak var ItemRoomOptionLabel: UILabel!
    @IBOutlet weak var ItemsLabel: UILabel!
    @IBOutlet weak var MoveButton: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!
    
    var currentTrack: String?
    var currentCharacter = characterBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLogic.initGame()
        currentCharacter.initCharacter()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView(){
        ItemRoomDiscription.text = gameLogic.getCurrentST().StoryTabDiscription
        ItemRoomOptionLabel.text = gameLogic.getCurrentST().StoryTabMoveDiscription1
        var itemString = ""
        for item in gameLogic.getCurrentST().items {
            itemString = itemString + item.Name + "\n"
        }
        ItemsLabel.text = itemString
    }
    
    
    
    @IBAction func moveButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        for item in gameLogic.getCurrentST().items {
            currentCharacter.addItem(item: item)
        }
        
        gameLogic.saveGame(save: gameLogic.getCurrentST().StoryTabMoveID1)
        coordinator?.itemToStory(vc: self)
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        coordinator?.itemToInventory(vc: self)
    }
}
