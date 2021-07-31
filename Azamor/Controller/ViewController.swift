//
//  ViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/06/30.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVPlayer?
    var aB = audioBrain()
    var gameLogic = gameBrain()
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLogic.initGame()
        playBackgroundVideo()
        aB.playBackgroundSound("Start")
        // Do any additional setup after loading the view.
    }
    
    func playBackgroundVideo() {
        guard let path = Bundle.main.path(forResource: "GameBack", ofType: "mp4") else {
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

    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMenu" {
            let destinationVC = segue.destination as! MainMenuViewController
            destinationVC.aB = aB
            destinationVC.gameLogic = gameLogic
        }
    }
    
}


