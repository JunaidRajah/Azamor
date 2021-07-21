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
    
    @IBOutlet weak var ItemRoomDiscription: UILabel!
    @IBOutlet weak var ItemRoomOptionLabel: UILabel!
    @IBOutlet weak var ItemsLabel: UILabel!
    @IBOutlet weak var MoveButton: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!
    
    var currentGame: Game?
    var currentStoryTab: StoryTab?
    var roomItems: List<Item>?
    var currentTrack: String?
    var currentCharacter = characterBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentGame = realm.objects(Game.self).first
        let storyTab = realm.objects(StoryTab.self)
        let pred = "StoryTabID = '\(String(describing: currentGame!.CurrentStoryTab))'"
        print(pred)
        currentStoryTab = storyTab.filter(pred).first
        print(currentStoryTab?.StoryTabID ?? "error getting correct tab")
        currentCharacter.initCharacter()
        roomItems = currentStoryTab!.items
        
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView(){
        ItemRoomDiscription.text = currentStoryTab!.StoryTabDiscription
        ItemRoomOptionLabel.text = currentStoryTab!.StoryTabMoveDiscription1
        var itemString = ""
        for item in roomItems! {
            itemString = itemString + item.Name + "\n"
        }
        ItemsLabel.text = itemString
    }
    
    
    
    @IBAction func moveButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        for item in roomItems! {
            currentCharacter.addItem(item: item)
        }
        
        do {
            let game = realm.objects(Game.self).first!
            try realm.write {
                game.setValue(currentStoryTab!.StoryTabMoveID1, forKey: "CurrentStoryTab")
            }
        } catch  {
            print(error)
        }
        performSegue(withIdentifier: "itemToStory", sender: self)
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        performSegue(withIdentifier: "itemToInventory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemToInventory" {
            let destinationVC = segue.destination as! InventoryViewController
            destinationVC.isFromItem = true
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "itemToStory" {
            let destinationVC = segue.destination as! StoryTabViewController
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
    }
}
