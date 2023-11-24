//
//  VideoPlayView.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 24.11.2023.
//

import UIKit
import AVFoundation

class VideoPlayView: UIView{
    let playerLayer: AVPlayerLayer = AVPlayerLayer()
    
    override class var layerClass: AnyClass{
        return AVPlayerLayer.self
    }
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        //backgroundColor = .black
        playerLayer.frame = bounds
    }
}
