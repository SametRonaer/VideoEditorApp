//
//  DummyPlayerVC.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import UIKit
import AVFoundation

class DummyPlayerVC: UIViewController{
    var player: AVPlayer?
    var playerView: UIView?
    
    override func viewDidAppear(_ animated: Bool) {
        playerView = DummyPlayerView()
        playerView!.backgroundColor = .black
        playerView!.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.addSubview(playerView!)
        playerView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerView!.heightAnchor.constraint(equalToConstant: 200).isActive = true
        setupPlayer()
    }
    
    func setupPlayer() {
           // create player item from streaming url
           let path = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
           let playerItem = AVPlayerItem(url: URL(string: path)!)
           
           // create player using player item
           player = AVPlayer(playerItem: playerItem)
           
           // create AVPlayerLayer for the player and add to the player view
           let layer = AVPlayerLayer(player: player)
           layer.frame = playerView!.bounds
           playerView!.layer.addSublayer(layer)
           
           // add necessary observers to observe the properties
           playerItem.addObserver(self, forKeyPath: "status", options: [], context: nil)
           playerItem.addObserver(self, forKeyPath: "duration", options: [], context: nil)
       }
    
   
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           guard let key = keyPath else { return }
           switch key {
           // play the player once player is ready to play
           case "status":
               if player?.status == .readyToPlay {
                   //player?.play()
               }
           // access the duration once available and use it
           case "duration": let duration = player!.currentItem?.duration
           //durationLabel.text = "\(CMTimeGetSeconds(duration!))" // in seconds
           default: break
           }
       }
}
