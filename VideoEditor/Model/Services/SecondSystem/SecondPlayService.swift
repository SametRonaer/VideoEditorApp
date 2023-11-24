

//
//  AssetPlayService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 13.10.2023.
//

import AVFoundation


class SecondPlayService{
    var currentPlayerItem: AVPlayerItem?
    
    var player: AVPlayer =  AVPlayer()
    
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
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = playerFrame ?? .zero
    }
    
    
    func playCurrentComposition(asset: AVAsset){
        print("Play")
        //let composition = getComposition(items: items)
        playAsset(asset: asset)
        //dummyPlayer()
    }
    
    private func getComposition(items: [SecondVideoComposerItem]) -> AVComposition{
        let composition = AVMutableComposition()
        items.forEach { item in
            // TODO fix only video option in here
            let compositionTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
            try! compositionTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: item.duration!.duration), of: compositionTrack!, at: .zero)
            print(compositionTrack)
        }
        return composition
    }
    
    
 
    
    func playAsset(asset: AVAsset) {
        currentAsset = asset
        currentPlayerItem = AVPlayerItem(asset: asset)
        
        if playerLayer == nil{
            print("Please fill player layer to play")
            return
        }
        player.play()
        
        
        subscribers.forEach({
            $0.didPlay()
        })
    }
    
    
    
    func dummyPlayer() {
            // create player item from streaming url
            let path = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
            let playerItem = AVPlayerItem(url: URL(string: path)!)
            
            // create player using player item
            //player!.replaceCurrentItem(with: playerItem)
            //player!.play()
            print("Boo")
            
        // create AVPlayerLayer for the player and add to the player view
           
            
            // add necessary observers to observe the properties
        //playerItem.addObserver(self as! NSObject, forKeyPath: "status", options: [], context: nil)
        //playerItem.addObserver(self as! NSObject, forKeyPath: "duration", options: [], context: nil)
        }
    
    func stopAsset() {
       // player?.pause()
        subscribers.forEach({
            $0.didStop()
        })
    }
    
    func pauseAsset() {
       // player?.pause()
        subscribers.forEach({
            $0.didPause()
        })
    }
    
 
    
    
    
}
