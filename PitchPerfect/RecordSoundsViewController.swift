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
    
    enum recordingState { case recording, notRecording }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureUI(.notRecording)
    }

    // MARK: Start Recording Audio
    @IBAction func startRecording(_ sender: AnyObject) {
        configureUI(.recording)
        
        // Create path for recorded audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        //let filePath = URL.fileURL(withPathComponents: pathArray)
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        // Create audio session and record audio
        let session = AVAudioSession.sharedInstance()
        /* on iPhones the default is set to the receiver when no headphone is used
           so set default to speaker */
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    
    // MARK: Stop Recording Audio
    @IBAction func stopRecording(_ sender: AnyObject) {
        configureUI(.notRecording)
        // stop recording and deactivate audio session
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // make sure recorded file finished saving
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            createAlert("Saving of recording failed")
        }
    }
    
    // call next view when recording finished
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // MARK: UI Function
    func configureUI(_ recordState: recordingState) {
        // disabel/enabel buttons for actual state
        switch(recordState) {
        case .recording:
            recordingLabel.text = "Recording in progress"
            recordButton.isEnabled = false
            stopRecordingButton.isEnabled = true
        case .notRecording:
            recordingLabel.text = "Tap to record"
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
        }
    }
    
    // MARK: Create Alert Message
    func createAlert(_ alertMessage: String) {
        let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

