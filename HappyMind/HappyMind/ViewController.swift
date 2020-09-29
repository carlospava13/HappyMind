//
//  ViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 26/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindData
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiClient = ApiClient()
        apiClient.getSongs { (result) in
            switch result {
            case .success(let url):
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    //guard let player = audioPlayer else { return }

                    self.audioPlayer.prepareToPlay()
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func onPlay(_ sender: Any) {
        audioPlayer.play()
    }
}

