//
//  AssetPlayService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 13.10.2023.
//

import AVFoundation



class AssetPlayService: AssetPlayServiceProtocol{
    var currentPlayerItem: AVPlayerItem?
    
    var player: AVPlayer?
    
    var currentAsset: AVAsset?
    
    var playerLayer: AVPlayerLayer?
    
    var playerFrame: CGRect?
    
    private var subscribers : [AssetPlayServiceSubscriber] = []
    
    func subscribe(subscriber: AssetPlayServiceSubscriber){
        subscribers.append(subscriber)
    }
    
    init(){
        configurePlayer()
    }
    
    init(frame: CGRect){
        playerFrame = frame
        configurePlayer()
    }
    
    private func configurePlayer(){
        player = AVPlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = playerFrame ?? .zero
    }
    
    
    func playCurrentComposition(tracks: [AVAssetTrack]){
        
    }
    
    
    func playAsset(asset: AVAsset) {
        currentAsset = asset
        currentPlayerItem = AVPlayerItem(asset: asset)
        
        if playerLayer == nil{
            print("Please fill player layer to play")
            return
        }
        
        if player == nil{
            player = AVPlayer(playerItem: currentPlayerItem)
        }else{
            player!.replaceCurrentItem(with: currentPlayerItem)
        }
        
        player?.play()
        subscribers.forEach({
            $0.didPlay()
        })
    }
    
    func stopAsset() {
        player?.pause()
        subscribers.forEach({
            $0.didStop()
        })
    }
    
    func pauseAsset() {
        player?.pause()
        subscribers.forEach({
            $0.didPause()
        })
    }
    
 
    
    
    
}
