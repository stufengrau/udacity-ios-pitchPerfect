//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Heike Bernhard on 03/08/16.
//  Copyright © 2016 stufengrau. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int {
        case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb
    }
    
    @IBAction func playSoundForButton(sender: UIButton) {
        print("Play Sound Button Pressed")
        
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stop Audio Button Pressed")
        
        configureUI(.NotPlaying)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("PlaySoundsViewController loaded")
        setupAudio()
    }

    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
