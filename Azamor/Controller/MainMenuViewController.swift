//
//  MainMenuViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/06/30.
//

import UIKit
import AVFoundation
import RealmSwift

class MainMenuViewController: UIViewController {

    let realm = try! Realm()
    var player: AVPlayer?
    var aB = audioBrain()
    var currentTrack = "Start"
    
    @IBOutlet weak var charButton: UIButton!
    @IBOutlet weak var armButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundVideo()
            
        let currentGame = realm.objects(Game.self).first
        
        let storyTabs = realm.objects(StoryTab.self)
        let pred = "StoryTabID = '\(String(describing: currentGame!.CurrentStoryTab))'"
        
        var currentStoryTab = storyTabs.filter(pred).first
        
        if currentStoryTab!.StoryTabID == "S01a" || currentStoryTab!.StoryTabID == "S01b" || currentStoryTab!.StoryTabID == "S01c" || currentStoryTab!.StoryTabID == "S01d"
            || currentStoryTab!.StoryTabID == "S01e" || currentStoryTab!.StoryTabID == "S01f" || currentStoryTab!.StoryTabID == "S01g" || currentStoryTab!.StoryTabID == "S01h"
            || currentStoryTab!.StoryTabID == "S01i" || currentStoryTab!.StoryTabID == "S01j" || currentStoryTab!.StoryTabID == "S01k" || currentStoryTab!.StoryTabID == "S01l"
            || currentStoryTab!.StoryTabID == "S01m" || currentStoryTab!.StoryTabID == "S01n" || currentStoryTab!.StoryTabID == "S01oE" || currentStoryTab!.StoryTabID == "S01p"
            || currentStoryTab!.StoryTabID == "S02a" || currentStoryTab!.StoryTabID == "S02b" || currentStoryTab!.StoryTabID == "S02c" {
            
            charButton.isEnabled = false
            armButton.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterAzamorButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        let char = characterBrain()
        char.initCharacter()
        performSegue(withIdentifier: "showStoryTab", sender: self)
        
    }
    
    
    func playBackgroundVideo() {
        guard let path = Bundle.main.path(forResource: "MainMenuBack", ofType: "mp4") else {
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        
        player!.seek(to: CMTime.zero)
        player!.play()
        self.player?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd() {
        player!.seek(to: CMTime.zero)
    }
    @IBAction func inventoryButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        performSegue(withIdentifier: "mainToInventory", sender: self)
    }
    
    @IBAction func characterButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        performSegue(withIdentifier: "mainToChar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToInventory" {
            let destinationVC = segue.destination as! InventoryViewController
            destinationVC.isFromMain = true
            destinationVC.aB = aB
            destinationVC.currentTrack = currentTrack
        }
        
        if segue.identifier == "mainToChar" {
            let destinationVC = segue.destination as! MyCharacterViewController
            destinationVC.aB = aB
            destinationVC.isFromMain = true
            destinationVC.currentTrack = currentTrack
        }
        
        if segue.identifier == "showStoryTab" {
            let destinationVC = segue.destination as! StoryTabViewController
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
    }
}
