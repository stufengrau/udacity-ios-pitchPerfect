//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Heike Bernhard on 01/08/16.
//  Copyright © 2016 stufengrau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startRecording(sender: AnyObject) {
        print("startRecording Button pressed.")
        recordingLabel.text = "Recording in progress"
        recordButton.enabled = false
        stopRecordingButton.enabled = true
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("stopRecording Button pressed.")
        stopRecordingButton.enabled = false
        recordButton.enabled = true
        recordingLabel.text = "Tap to record"
    }
}

