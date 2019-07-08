//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Charlie Scheer on 7/8/19.
//  Copyright © 2019 Praxsis. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var pitchUpButton: UIButton!
    @IBOutlet weak var pitchDownButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    @IBAction func playAudioWithEffectTapped(_ sender: UIButton) {
        //Depending on which button is tapped replay recorded audio with selected effect
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonWasTapped(_ sender: Any) {
        //return playback view to inactive state
        stopAudio()
        configureUI(.notPlaying)
    }

}
