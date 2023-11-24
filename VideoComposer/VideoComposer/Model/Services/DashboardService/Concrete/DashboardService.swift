//
//  DashboardService.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import AVFoundation

class DashboardService{
    var composerViewConfig: ComposerViewConfigModel!
    
    init(composerViewConfig: ComposerViewConfigModel!) {
        self.composerViewConfig = composerViewConfig
    }
    
    func addAssetToConfig(asset: AVAsset, id: UUID?){
        composerViewConfig.sequences.forEach { seq in
            if(seq.id == id){
                seq.asset = asset
            }
            seq.asset = asset
        }
    }
    
    func getCurrentComposition() -> AVAsset{
        let videoComposition = AVMutableComposition()
        var lastTime: CMTime = CMTime.zero
        let videoCompositionTrack = videoComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        for seq in composerViewConfig.sequences {
            if let currentAsset = seq.asset{
                do {
                    try videoCompositionTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: currentAsset.duration),
                                                              of: currentAsset.tracks(withMediaType: AVMediaType.video)[0] ,
                                                        at: lastTime)
                    lastTime = CMTimeAdd(lastTime, currentAsset.duration)
                } catch {
                    print("Failed to insert track")
                }
            }
        }
        return videoComposition
    }
}
