//
//  MainMenuViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/06/30.
//

import UIKit
import AVFoundation
import RealmSwift

class MainMenuViewController: UIViewController, Storyboarded {

    var coordinator: MainCoordinator?
    let realm = try! Realm()
    var player: AVPlayer?
    var aB = audioBrain.audioInstance
    var gameLogic = gameBrain.gameInstance
    var currentTrack = "Start"
    
    @IBOutlet weak var charButton: UIButton!
    @IBOutlet weak var armButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLogic.initGame()
        initView()
    }
    
    func initView() {
        playBackgroundVideo()
        if gameLogic.checkIfStartingCharIsActive() {
            charButton.isEnabled = false
            armButton.isEnabled = false
        }
    }
    
    @IBAction func enterAzamorButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        let char = characterBrain()
        char.initCharacter()
        coordinator?.mainToStory(vc: self)
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
        coordinator?.mainToInventory(vc: self)
    }
    
    @IBAction func characterButtonPressed(_ sender: UIButton) {
        aB.playButtonSound("buttonClicked")
        coordinator?.mainToChar(vc: self)
    }
    
}
