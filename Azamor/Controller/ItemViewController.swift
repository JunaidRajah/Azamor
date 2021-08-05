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
    var itemViewModel = ItemViewModel()
    
    @IBOutlet weak var ItemRoomDiscription: UILabel!
    @IBOutlet weak var ItemRoomOptionLabel: UILabel!
    @IBOutlet weak var ItemsLabel: UILabel!
    @IBOutlet weak var MoveButton: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView(){
        itemViewModel.initView()
        
        ItemRoomDiscription.text = itemViewModel.itemRoomDiscriptionText
        ItemRoomOptionLabel.text = itemViewModel.itemRoomOptionLabelText
        ItemsLabel.text = itemViewModel.ItemsLabelText
    }
    
    @IBAction func moveButtonPressed(_ sender: UIButton) {
        itemViewModel.moveButtonPressed()
        coordinator?.itemToStory(vc: self)
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        itemViewModel.playButtonSound()
        coordinator?.itemToInventory(vc: self)
    }
}
