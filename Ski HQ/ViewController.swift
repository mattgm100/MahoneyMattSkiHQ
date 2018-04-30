//
//  ViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/23/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var skierImage: UIImageView!
    @IBOutlet weak var mountainImage: UIImageView!
    
    
    @IBOutlet weak var hitSlopesButton: UIButton!
    var xAtStart: CGFloat = 0
    var originalSecondX: CGFloat!
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        xAtStart = skierImage.frame.origin.x
    }
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        moveSkier()
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset (name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print ("Error")
            }
        } else {
            print ("Another Error")
        }
    }
    
    func moveSkier() {
        playSound(soundName: "SkiSound", audioPlayer: &audioPlayer)
        if skierImage.frame.origin.x < 0 {
            UIView.animate(withDuration: 2, animations: {self.skierImage.frame.origin.x = self.xAtStart}) { _ in self.audioPlayer.stop()
            }
            hitSlopesButton.setTitle("Hit the Slopes!", for: .normal)
        } else {
            UIView.animate(withDuration: 2, animations: {self.skierImage.frame.origin.x = -(self.skierImage.frame.width) }) { _ in self.audioPlayer.stop()
            }
        }
    }
    
    @IBAction func hitSlopesPressed(_ sender: UIButton) {
        moveSkier()
    }
    
    
}



