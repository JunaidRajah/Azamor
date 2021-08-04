//
//  StoryTabViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/03.
//

import UIKit
import RealmSwift
import CLTypingLabel
import AVFoundation

class StoryTabViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    var storyTabViewModel = StoryTabViewModel()

    @IBOutlet weak var StoryTabTitleLabel: UILabel!
    @IBOutlet weak var StoryTabDiscriptionLabel: CLTypingLabel!
    @IBOutlet weak var Option1Btn: UIButton!
    @IBOutlet weak var Option2Btn: UIButton!
    @IBOutlet weak var Option3Btn: UIButton!
    @IBOutlet weak var Option4Btn: UIButton!
    @IBOutlet weak var BackOptionBtn: UIButton!
    @IBOutlet weak var ForwardOptionBtn: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var OptionImage1: UIImageView!
    @IBOutlet weak var OptionImage2: UIImageView!
    @IBOutlet weak var OptionImage3: UIImageView!
    @IBOutlet weak var OptionImage4: UIImageView!
    
    @IBOutlet weak var BackOptionImage: UIImageView!
    @IBOutlet weak var ForwardOptionImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var OptionLabel1: UILabel!
    @IBOutlet weak var OptionLabel2: UILabel!
    @IBOutlet weak var OptionLabel3: UILabel!
    @IBOutlet weak var OptionLabel4: UILabel!
    
    @IBOutlet weak var BackOptionLabel: UILabel!
    @IBOutlet weak var ForwardOptionLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        storyTabViewModel.initBackgroundMusic()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkFromRoom()
    }
    
    func initView(){
        
        if storyTabViewModel.checkIfStartingCharIsActive() {
            inventoryButton.isHidden = true
        } else {
            inventoryButton.isHidden = false
        }
        
        storyTabViewModel.playVoiceSound()
        
        print(storyTabViewModel.currentStoryTabString ?? "error getting correct tab")
        StoryTabTitleLabel.text = storyTabViewModel.StoryTabChapterName
        StoryTabDiscriptionLabel.charInterval = 0.06
        StoryTabDiscriptionLabel.text = storyTabViewModel.StoryTabDiscription
        backgroundImage.image = UIImage(named: storyTabViewModel.StoryTabBackgroundImageString!)
        
        if (storyTabViewModel.StoryTabMoveActive1 == true) {
            showUI(OptionBtn: Option1Btn, OptionImage: OptionImage1, OptionLabel: OptionLabel1)
            OptionLabel1.text = storyTabViewModel.StoryTabMoveDiscription1

        } else {
            hideUI(OptionBtn: Option1Btn, OptionImage: OptionImage1, OptionLabel: OptionLabel1)
        }
        
        if (storyTabViewModel.StoryTabMoveActive2 == true) {
            showUI(OptionBtn: Option2Btn, OptionImage: OptionImage2, OptionLabel: OptionLabel2)
            OptionLabel2.text = storyTabViewModel.StoryTabMoveDiscription2
        } else {
            hideUI(OptionBtn: Option2Btn, OptionImage: OptionImage2, OptionLabel: OptionLabel2)
        }
        
        if (storyTabViewModel.StoryTabMoveActive3 == true) {
            showUI(OptionBtn: Option3Btn, OptionImage: OptionImage3, OptionLabel: OptionLabel3)
            OptionLabel3.text = storyTabViewModel.StoryTabMoveDiscription3
        } else {
            hideUI(OptionBtn: Option3Btn, OptionImage: OptionImage3, OptionLabel: OptionLabel3)
        }
        
        if (storyTabViewModel.StoryTabMoveActive4 == true) {
            showUI(OptionBtn: Option4Btn, OptionImage: OptionImage4, OptionLabel: OptionLabel4)
            OptionLabel4.text = storyTabViewModel.StoryTabMoveDiscription4
        } else {
            hideUI(OptionBtn: Option4Btn, OptionImage: OptionImage4, OptionLabel: OptionLabel4)
        }
        
        if (storyTabViewModel.StoryTabBackActive == true) {
            showUI(OptionBtn: BackOptionBtn, OptionImage: BackOptionImage, OptionLabel: BackOptionLabel)
            BackOptionLabel.text = storyTabViewModel.StoryTabBackDiscription
        } else {
            hideUI(OptionBtn: BackOptionBtn, OptionImage: BackOptionImage, OptionLabel: BackOptionLabel)
        }
        
        if (storyTabViewModel.StoryTabFowardActive == true) {
            showUI(OptionBtn: ForwardOptionBtn, OptionImage: ForwardOptionImage, OptionLabel: ForwardOptionLabel)
            ForwardOptionLabel.text = storyTabViewModel.StoryTabFowardDiscription
        } else {
            hideUI(OptionBtn: ForwardOptionBtn, OptionImage: ForwardOptionImage, OptionLabel: ForwardOptionLabel)
        }
    }
    
    func showUI(OptionBtn: UIButton, OptionImage: UIImageView, OptionLabel: UILabel){
        OptionBtn.isHidden = false
        OptionImage.isHidden = false
        OptionLabel.isHidden = false
    }
    
    func hideUI(OptionBtn: UIButton, OptionImage: UIImageView, OptionLabel: UILabel){
        OptionBtn.isHidden = true
        OptionImage.isHidden = true
        OptionLabel.isHidden = true
    }
    
    @IBAction func OptionButtonPressed(_ sender: UIButton) {
        storyTabViewModel.playOptionButtonSound()
        
        if storyTabViewModel.OptionButtonAction(button: sender.tag) {
            coordinator?.storyToDice(vc: self)
        } else {
            checkNextRoom()
        }
        
        if storyTabViewModel.checkCharSelect(){
            coordinator?.storyToSelect(vc: self)
        }
        storyTabViewModel.initBackgroundMusic()
        initView()
    }
    
    
    
    func checkNextRoom(){
        if storyTabViewModel.checkNextEncounter() {
            coordinator?.storyToEncounter(vc: self)
        }
        if storyTabViewModel.checkNextItemRoom() {
            coordinator?.storyToItems(vc: self)
        }
    }
    
    func checkFromRoom(){
        storyTabViewModel.checkFromRoom()
        if storyTabViewModel.checkFromEncounter() {
            coordinator?.storyToEncounter(vc: self)
        }
        if storyTabViewModel.checkFromItemRoom() {
            coordinator?.storyToItems(vc: self)
        }
    }
    
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        storyTabViewModel.changeButtonPressed()
        coordinator?.storyToInventory(vc: self)
        
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        storyTabViewModel.changeButtonPressed()
        coordinator?.storyToMain(vc: self)
        
    }
    

}
