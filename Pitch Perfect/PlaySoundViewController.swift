//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Michael Stevens on 3/28/15.
//  Copyright (c) 2015 Michael Stevens. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            println(filePath);
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
            audioPlayer.enableRate = true
        } else {
            println("the filePath is empty")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundSlow(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }

    @IBAction func playSoundFast(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        audioPlayer.stop()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
