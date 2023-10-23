//
//  AssetPlayServiceAbstracy.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 20.10.2023.
//

import AVFoundation


protocol AssetPlayServiceProtocol{
    func playAsset(asset:AVAsset)

    func stopAsset()
    func pauseAsset()
    
    var currentAsset: AVAsset? { get }
    var player: AVPlayer? {get set}
    var playerLayer: AVPlayerLayer? {get set}
    var currentPlayerItem: AVPlayerItem? {get set}
}

protocol AssetPlayServiceSubscriber{
    func didPlay()
    func didStop()
    func didPause()
}
