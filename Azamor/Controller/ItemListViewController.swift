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
    var itemListViewModel = ItemListViewModel()
    
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
    
    var isPlayerTurn = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        itemListViewModel.passIndexToChange(index: indexToChange!)
        initView()
    }
    
    func initView(){
        switch itemListViewModel.itemListAmount {
        case 0:
            Item1Label.isHidden = false
            Item1Label.text = itemListViewModel.item1LabelText
        case 1:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item1Label.text = itemListViewModel.item1LabelText
        case 2:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item2Label.isHidden = false
            Item2Button.isHidden = false
            
            Item1Label.text = itemListViewModel.item1LabelText
            Item2Label.text = itemListViewModel.item2LabelText
        case 3:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item2Label.isHidden = false
            Item2Button.isHidden = false
            
            Item3Label.isHidden = false
            Item3Button.isHidden = false
            
            Item1Label.text = itemListViewModel.item1LabelText
            Item2Label.text = itemListViewModel.item2LabelText
            Item3Label.text = itemListViewModel.item3LabelText
        case 4:
            Item1Label.isHidden = false
            Item1Button.isHidden = false
            
            Item2Label.isHidden = false
            Item2Button.isHidden = false
            
            Item3Label.isHidden = false
            Item3Button.isHidden = false
            
            Item4Label.isHidden = false
            Item4Button.isHidden = false
            
            Item1Label.text = itemListViewModel.item1LabelText
            Item2Label.text = itemListViewModel.item2LabelText
            Item3Label.text = itemListViewModel.item3LabelText
            Item4Label.text = itemListViewModel.item4LabelText
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
            
            Item1Label.text = itemListViewModel.item1LabelText
            Item2Label.text = itemListViewModel.item2LabelText
            Item3Label.text = itemListViewModel.item3LabelText
            Item4Label.text = itemListViewModel.item4LabelText
            Item5Label.text = itemListViewModel.item5LabelText
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
            
            Item1Label.text = itemListViewModel.item1LabelText
            Item2Label.text = itemListViewModel.item2LabelText
            Item3Label.text = itemListViewModel.item3LabelText
            Item4Label.text = itemListViewModel.item4LabelText
            Item5Label.text = itemListViewModel.item5LabelText
            Item6Label.text = itemListViewModel.item6LabelText
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        itemListViewModel.addButtonPressed(button: sender.tag)
        coordinator?.listToInventory(vc: self)
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        itemListViewModel.playButtonSound()
        coordinator?.listToInventory(vc: self)
    }
}
