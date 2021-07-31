//
//  ItemViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift
import AVFoundation

class ItemViewController: UIViewController {

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
        performSegue(withIdentifier: "itemToStory", sender: self)
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        performSegue(withIdentifier: "itemToInventory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemToInventory" {
            let destinationVC = segue.destination as! InventoryViewController
            destinationVC.gameLogic = gameLogic
            destinationVC.isFromItem = true
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "itemToStory" {
            let destinationVC = segue.destination as! StoryTabViewController
            destinationVC.gameLogic = gameLogic
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
    }
}
