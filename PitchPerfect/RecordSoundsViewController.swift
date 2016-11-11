//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Heike Bernhard on 01/08/16.
//  Copyright © 2016 stufengrau. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    enum recordingState { case Recording, NotRecording }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureUI(.NotRecording)
    }

    // MARK: Start Recording Audio
    @IBAction func startRecording(sender: AnyObject) {
        configureUI(.Recording)
        
        // Create path for recorded audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        // Create audio session and record audio
        let session = AVAudioSession.sharedInstance()
        /* on iPhones the default is set to the receiver when no headphone is used
           so set default to speaker */
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    
    // MARK: Stop Recording Audio
    @IBAction func stopRecording(sender: AnyObject) {
        configureUI(.NotRecording)
        // stop recording and deactivate audio session
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // make sure recorded file finished saving
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            createAlert("Saving of recording failed")
        }
    }
    
    // call next view when recording finished
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // MARK: UI Function
    func configureUI(recordState: recordingState) {
        // disabel/enabel buttons for actual state
        switch(recordState) {
        case .Recording:
            recordingLabel.text = "Recording in progress"
            recordButton.enabled = false
            stopRecordingButton.enabled = true
        case .NotRecording:
            recordingLabel.text = "Tap to record"
            recordButton.enabled = true
            stopRecordingButton.enabled = false
        }
    }
    
    // MARK: Create Alert Message
    func createAlert(alertMessage: String) {
        let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}

