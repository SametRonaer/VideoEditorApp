//
//  SecondDashboardService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import Foundation
import AVFoundation

protocol SecondDashboardServiceSubscriber{
    func didItemAdded(item: SecondVideoComposerItem)
}

class SecondDashboardService{
    let composerConfig: SecondConfigModel
    var composerItems: [SecondVideoComposerItem] = .init()
    
    let videoComposition = AVMutableComposition()
    var lastTime: CMTime = CMTime.zero
    
    private var subscribers: [SecondDashboardServiceSubscriber] = []
    
    func addSubscriber(subscriber: SecondDashboardServiceSubscriber){
        subscribers.append(subscriber)
    }
    
    
    
    init(composerConfig: SecondConfigModel) {
        self.composerConfig = composerConfig
    }
    
    func addNewComposerItemToDashboard(item: SecondVideoComposerItem){
        composerItems.append(item)
        subscribers.forEach {
            $0.didItemAdded(item: item)
        }
    }
    
    func getComposition() -> AVAsset?{
        let videoCompositionTrack = videoComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        
        for clipIndex in composerItems {
            do {
                try videoCompositionTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: clipIndex.asset!.duration),
                                                           of: clipIndex.asset!.tracks(withMediaType: AVMediaType.video)[0] ,
                                                        at: lastTime)
                
                lastTime = CMTimeAdd(lastTime, clipIndex.asset!.duration)
            } catch {
                print("Failed to insert track")
            }
        }
        print("VideoComposition Tracks: \(videoComposition.tracks.count)") // Shows multiple tracks
        return videoComposition
        
    }
    
}
