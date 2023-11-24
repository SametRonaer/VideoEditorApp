//
//  PlayService.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import AVFoundation

class PlayService{
    
    var videoPlayer: AVPlayer?
    
    func playCurrentComposition(composition: AVAsset, playerLayer:AVPlayerLayer){
        let playerItem = AVPlayerItem(asset: composition)
        videoPlayer = AVPlayer(playerItem: playerItem)
        playerLayer.player = videoPlayer
        videoPlayer!.volume = 0.0
        videoPlayer!.play()
    }
    
}
