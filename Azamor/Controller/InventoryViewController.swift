//
//  InventoryViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift
import AVFoundation

class InventoryViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    var inventoryViewModel = InventoryViewModel()
    
    @IBOutlet weak var Weapon1Image: UIImageView!
    @IBOutlet weak var Weapon2Image: UIImageView!
    @IBOutlet weak var ArmorImage: UIImageView!
    @IBOutlet weak var RingImage: UIImageView!
    @IBOutlet weak var Usable1Image: UIImageView!
    @IBOutlet weak var Usable2Image: UIImageView!
    @IBOutlet weak var charImage: UIImageView!
    
    @IBOutlet weak var Weapon1Button: UIButton!
    @IBOutlet weak var Weapon2Button: UIButton!
    @IBOutlet weak var ArmorButton: UIButton!
    @IBOutlet weak var Ring1Button: UIButton!
    @IBOutlet weak var Usable1Button: UIButton!
    @IBOutlet weak var Usable2Button: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var indexToChange = 0
    var isFromMain = false
    var isFromStory = false
    var isFromItem = false
    var isFromEncounter = false
    var isPlayerTurn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        charImage.image = UIImage(named: inventoryViewModel.charImageString!)
       
        Weapon1Image.image = UIImage(named: inventoryViewModel.Weapon1ImageString!)
    
        Weapon2Image.image = UIImage(named: inventoryViewModel.Weapon2ImageString!)
   
        ArmorImage.image = UIImage(named: inventoryViewModel.ArmorImageString!)
    
        RingImage.image = UIImage(named: inventoryViewModel.RingImageString!)

        Usable1Image.image = UIImage(named: inventoryViewModel.Usable1ImageString!)
    
        Usable2Image.image = UIImage(named: inventoryViewModel.Usable2ImageString!)
    }
    
    @IBAction func itemButtonPressed(_ sender: UIButton) {
        indexToChange = sender.tag
        inventoryViewModel.itemButtonPressed(button: indexToChange)
        coordinator?.inventoryToList(vc: self)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        inventoryViewModel.playButtonSound()
        if isFromMain == true {
            coordinator?.inventoryToMain(vc: self)
        }
        else if isFromStory == true {
            coordinator?.inventoryToStory(vc: self)
        }
        else if isFromItem == true {
            coordinator?.inventoryToItem(vc: self)
        }
        else if isFromEncounter == true {
            coordinator?.inventoryToEncounter(vc: self)
        }
    }
}
