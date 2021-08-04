//
//  audioBrain.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/09.
//

import Foundation
import RealmSwift
import AVFoundation

class audioBrain {
    static let audioInstance = audioBrain()
    var audioPlayerBack: AVAudioPlayer?
    var audioPlayerButton: AVAudioPlayer?
    var audioPlayerVoice: AVAudioPlayer?
    
    func playButtonSound(_ answer: String){
        let pathToSound = Bundle.main.path(forResource: answer, ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do{
            audioPlayerButton = try AVAudioPlayer(contentsOf: url)
            audioPlayerButton?.play()
        } catch {
            //future error handling when the knowledge becomes available
        }
    }
    
    func playBackgroundSound(_ answer: String){
        let pathToSound = Bundle.main.path(forResource: answer, ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do{
            audioPlayerBack = try AVAudioPlayer(contentsOf: url)
            audioPlayerBack?.volume = 0.5
            audioPlayerBack?.numberOfLoops = -1
            audioPlayerBack?.play()
        } catch {
            //future error handling when the knowledge becomes available
        }
    }
    
    func stopSoundBack(){
        audioPlayerBack?.stop()
    }
    
    func playVoiceSound(_ answer: String){
        let pathToSound = Bundle.main.path(forResource: answer, ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do{
            audioPlayerVoice = try AVAudioPlayer(contentsOf: url)
            audioPlayerVoice?.play()
        } catch {
            //future error handling when the knowledge becomes available
        }
    }
    
    func stopVoice(){
        audioPlayerVoice?.stop()
    }
    
    
}
