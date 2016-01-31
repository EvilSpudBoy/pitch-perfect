//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Stevens on 3/23/15.
//  Copyright (c) 2015 Michael Stevens. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        //Hide the stop button
        stopButton.hidden = true
        pauseButton.hidden = true
        resumeButton.hidden = true
        recordButton.enabled = true
    }
    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.text = "Recording in Progress"
        stopButton.hidden = false
        pauseButton.hidden = false
        recordButton.enabled = false
        //TODO: Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        // Setup audio session
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            // Initialize and prepare the recorder
            audioRecorder =  try AVAudioRecorder(URL: filePath!, settings: [String : AnyObject]())
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
        }
    }

    @IBAction func pauseRecording(sender: UIButton) {
        audioRecorder.pause()
        resumeButton.hidden = false
        pauseButton.hidden = true
    }
    
    @IBAction func resumeRecording(sender: UIButton) {
        audioRecorder.record()
        resumeButton.hidden = true
        pauseButton.hidden = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            recordedAudio = RecordedAudio(title: audioRecorder.url.lastPathComponent!, filePathUrl: audioRecorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording was not successfule")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
        }
    }
}

