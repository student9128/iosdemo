//
//  SixViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/6/25.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class SixViewController:UIViewController{
    var playerWithItem:AVPlayer?
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.lightGray
        let url = "https://live.idbhost.com/05d2556e74e9408db0ee370b41536282/d4d54975f8a34b21bd9061ac0464a092-bafd00dba653149fda08dc8743bf8820-sd.mp4"
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let playerItem = AVPlayerItem(url:URL(string: url)!)
//        playerWithItem = AVPlayer(playerItem: playerItem)
//        playerWithItem!.rate=1.0
//        playerLayer = AVPlayerLayer.init(player: playerWithItem)
        // Set up player
        let videoURL = URL(string: url)!
        self.player = AVPlayer(url: videoURL)
        self.playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame=CGRect(x: 0, y: 0, width: width, height: 300)
        self.view.layer.addSublayer(self.playerLayer)
        self.player?.play()
        
//        playerLayer.player?.play()
        PictureInPictureManager.shared.initPiPManager(playerLayer: playerLayer)
        let x=PictureInPictureManager.shared.canStartPipAuto
        print("x===\(x)")
        
        // Add start PiP button
        let startButton = UIButton(type: .system)
//        startButton.frame=CGRect(x: 20, y: 400, width: 50, height: 50)
        startButton.setTitle("Start PiP", for: .normal)
        startButton.addTarget(self, action: #selector(startPictureInPictureTapped(sender:)), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        // Add stop PiP button
        let stopButton = UIButton(type: .system)
//        stopButton.frame=CGRect(x: 20, y: 460, width: 50, height: 50)
        stopButton.setTitle("Stop PiP", for: .normal)
        stopButton.addTarget(self, action: #selector(stopPictureInPictureTapped(sender:)), for: .touchUpInside)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stopButton)
        NSLayoutConstraint.activate([
            stopButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 16)
        ])
    }
    // MARK: - IBActions
    
    @objc func startPictureInPictureTapped(sender: UIButton) {
    
        print("x===\(player),\(playerLayer.player)")
        PictureInPictureManager.shared.startPip()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func stopPictureInPictureTapped(sender: UIButton) {
        PictureInPictureManager.shared.stopPip()
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    
}
