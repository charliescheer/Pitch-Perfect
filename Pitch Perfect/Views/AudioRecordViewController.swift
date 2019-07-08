//
//  AudioRecordViewController.swift
//  Pitch Perfect
//
//  Created by Charlie Scheer on 7/8/19.
//  Copyright © 2019 Praxsis. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecordViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: ViewController Properties
    @IBOutlet weak var recordInProgressLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    // MARK: View Loading and Exiting
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViewToRecordingInactive()
    }

    // MARK: Record/Stop Button Functions
    @IBAction func recordButtonWasTapped(_ sender: Any) {
        //Set view to active recording
        changeViewToRecordingActive()
        
        //Define file path for recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = constants.recordingName
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        //Create audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        //Start recording
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.startRecording(delegate: self)
    }
    
    @IBAction func stopButtonWasTapped(_ sender: Any) {
        //Stop audio recorder and return to view to inactive recording state
        setupViewToRecordingInactive()
        audioRecorder.stop()
        
        //End audio session
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false, options: AVAudioSession.SetActiveOptions())
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            //If saving recording is successful load the playback view
            performSegue(withIdentifier: constants.playbackSegue, sender: audioRecorder.url)
        } else {
            //If saving failed
            print("Audio did not save")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == constants.playbackSegue {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // MARK: Setup View
    func setupViewToRecordingInactive() {
        stopButton.isEnabled = false
        recordButton.isEnabled = true
        recordInProgressLabel.text = constants.startRecordingLabel
    }
    
    func changeViewToRecordingActive() {
        stopButton.isEnabled = true
        recordButton.isEnabled = false
        recordInProgressLabel.text = constants.recordingInProgressLabel
    }
    
    
}

extension AudioRecordViewController {
    enum constants {
        static let playbackSegue = "AudioPlayback"
        static let recordingName = "recordedVoice.wav"
        static let startRecordingLabel = "Tap to Start Recording"
        static let recordingInProgressLabel = "Recording in progress"
    }
}

