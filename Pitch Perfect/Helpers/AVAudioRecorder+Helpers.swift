//
//  AVAudioRecorder+Helpers.swift
//  Pitch Perfect
//
//  Created by Charlie Scheer on 7/8/19.
//  Copyright © 2019 Praxsis. All rights reserved.
//

import Foundation
import AVFoundation

extension AVAudioRecorder {
    func startRecording(delegate: AudioRecordViewController) {
        //Function sets prepares the audio recorder to
        self.delegate = delegate
        self.isMeteringEnabled = true
        self.prepareToRecord()
        self.record()
    }
}
