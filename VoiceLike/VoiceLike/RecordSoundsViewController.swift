//
//  RecordSoundsViewController.swift
//  VoiceLike
//
//  Created by Alessio Papazzoni on 01/02/18.
//  Copyright © 2018 bussolalabs. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var labelPress: UILabel!
    @IBOutlet weak var buttonRecord: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelPress.text = "tap_to_record".localized
        buttonStop.isEnabled = false
    }

    @IBAction func audioRecord(_ sender: Any) {
        configureUI(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func audioStop(_ sender: Any) {
        configureUI(isRecording: false)
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            print(recordedAudioURL)
        }
    }
    
    func configureUI(isRecording: Bool) {
        buttonRecord.isEnabled = !isRecording
        buttonStop.isEnabled = isRecording
        labelPress.text = isRecording ? "recording_in_progress".localized : "tap_to_record".localized
    }
}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            showAlertOk(message: "recording_error")
        }
        
    }
}
