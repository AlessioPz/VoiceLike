//
//  PlaySoundsViewController.swift
//  VoiceLike
//
//  Created by Alessio Papazzoni on 01/02/18.
//  Copyright © 2018 bussolalabs. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var assetWriter: AVAssetWriter!
    var audioInput: AVAssetWriterInput!
    var assetReader: AVAssetReader!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case fast = 0, slow, echo, chipmunk, vader, reverb
    }
    
    // MARK: Outlets
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Actions
    @IBAction func playSoundForButton(_ sender: UIButton) {
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
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
        configureButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    func configure(button: UIButton) {
        button.imageView?.contentMode = .scaleAspectFit
    }
    
    func configureButtons() {
        configure(button: snailButton)
        configure(button: rabbitButton)
        configure(button: echoButton)
        configure(button: vaderButton)
        configure(button: reverbButton)
        configure(button: chipmunkButton)
        configure(button: stopButton)
    }
}
