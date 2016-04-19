//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Kevin Sutton on 4/19/16.
//  Copyright © 2016 Kevin Sutton. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    var audioPlayer: AVAudioPlayer!
    var audioDuration: String!

    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    @IBAction func playSoundForButton(sender: UIButton) {
        print("Play Sound Button Pressed")
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case.Slow:
            playSound(rate: 0.5)
        case.Fast:
            playSound(rate: 1.5)
        case.Chipmunk:
            playSound(pitch: 1000)
        case.Vader:
            playSound(pitch: -1000)
        case.Echo:
            playSound(echo: true)
        case.Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stop Audio Button Pressed")
        
        stopAudio()
        
    }
    
    func displayDuration() {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOfURL: recordedAudioURL)
            audioDuration = String(format:"Recording Duration:\n%3.1f seconds",audioPlayer.duration)
            
            print(audioDuration)
            durationLabel.text = audioDuration
        }
        catch
        {
            print("Error occurred getting duratrion time")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaySoundsViewController loaded")
        
        setupAudio()
        
        // Do any additional setup after loading the view.
        // Display Audio Duration in Label
        displayDuration()
    }
    
    override func viewDidAppear(animated: Bool) {
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
