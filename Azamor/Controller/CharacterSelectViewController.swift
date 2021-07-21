//
//  CharacterSelectViewController.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/07.
//

import UIKit
import RealmSwift

class CharacterSelectViewController: UIViewController {
    
    let realm = try! Realm()
    var aB = audioBrain()
    
    var currentGame: Game?
    
    var currentTrack: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGame = realm.objects(Game.self).first
        
    }
    
    @IBAction func moreButtonPresssed(_ sender: UIButton) {
        if sender.tag == 1 {
            do {
                let raziel = realm.objects(PlayerCharacter.self)[0]
                try realm.write {
                    currentGame!.setValue(raziel, forKey: "GamePlayerCharacter")
                }
            } catch  {
                print(error)
            }
            aB.playButtonSound("buttonClicked")
            performSegue(withIdentifier: "selectToChar", sender: self)
        }
        else if sender.tag == 2 {
            do {
                let razaila = realm.objects(PlayerCharacter.self)[1]
                try realm.write {
                    currentGame!.setValue(razaila, forKey: "GamePlayerCharacter")
                }
            } catch  {
                print(error)
            }
            aB.playButtonSound("buttonClicked")
            performSegue(withIdentifier: "selectToChar", sender: self)
        }
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            do {
                let raziel = realm.objects(PlayerCharacter.self)[0]
                try realm.write {
                    currentGame!.setValue(raziel, forKey: "GamePlayerCharacter")
                }
            } catch  {
                print(error)
            }
            aB.playButtonSound("buttonClicked")
            performSegue(withIdentifier: "selectToStory", sender: self)
        }
        else if sender.tag == 2 {
            do {
                let razaila = realm.objects(PlayerCharacter.self)[1]
                try realm.write {
                    currentGame!.setValue(razaila, forKey: "GamePlayerCharacter")
                }
            } catch  {
                print(error)
            }
            aB.playButtonSound("buttonClicked")
            aB.stopSoundBack()
            performSegue(withIdentifier: "selectToStory", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectToStory" {
            let destinationVC = segue.destination as! StoryTabViewController
            destinationVC.currentTrack = currentTrack
            destinationVC.aB = aB
        }
        
        if segue.identifier == "selectToChar" {
            let destinationVC = segue.destination as! MyCharacterViewController
            destinationVC.aB = aB
            destinationVC.currentTrack = currentTrack
            destinationVC.isFromMain = false
        }
        
        
    }

}
