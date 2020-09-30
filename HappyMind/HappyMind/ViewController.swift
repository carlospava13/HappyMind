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

    var player: AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://audio.clyp.it/uch2mlgn.mp3?Expires=1601357251&Signature=rIcNT6FYm9~voV93sKfKuDv~nQFuSIfHLt3vofDE7K3QWqcbARCnQXGEJcNMz11AJHv4PN0Q9R2ejCJak4WuH9tEkIC3fsmqLwyklce9HbHhHk1d70h1eAghUH1bRwQWyLWVGkgSFfpEwRMXGgXppvSkdU0z51KlkjoUsmzbHq0_&Key-Pair-Id=APKAJ4AMQB3XYIRCZ5PA")!
        let playerItem = CachingPlayerItem(url: url)
        playerItem.delegate = self   
        player = AVPlayer(playerItem: playerItem)
        player.automaticallyWaitsToMinimizeStalling = false
    }

    @IBAction func onPlay(_ sender: Any) {
        player.play()
    }
    
    @IBAction func onPush(_ sender: Any) {
        let viewController = CategoryViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: CachingPlayerItemDelegate {
    func progress(_ value: Float) {
        print(value)
    }
}
