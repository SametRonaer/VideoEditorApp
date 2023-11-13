//
//  DummyPlayerView.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import UIKit
import AVFoundation

class DummyPlayerView: UIView{
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
        
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
}
