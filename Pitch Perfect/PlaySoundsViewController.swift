//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Stevens on 3/28/15.
//  Copyright (c) 2015 Michael Stevens. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundSlow(sender: UIButton) {
        playbackAudioAtRate(0.5)
    }

    @IBAction func playSoundFast(sender: UIButton) {
        playbackAudioAtRate(2.0)
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func playSoundChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playSoundVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playSoundEcho(sender: UIButton) {
        playAudioWithEcho()
    }
    
    func playbackAudioAtRate(rate: Float) {
        audioEngine.stop()
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        playAudioWithEffect(changePitchEffect)
    }
    
    func playAudioWithEcho() {
        let echoEffect = AVAudioUnitDelay()
        echoEffect.delayTime = 0.5
        echoEffect.feedback = 0.9
        
        playAudioWithEffect(echoEffect)
    }
    
    func playAudioWithEffect(effect: AVAudioUnit) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(effect)
        
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch _ {
        }
        
        audioPlayerNode.play()
    }
}
