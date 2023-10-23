//
//  EditAssetService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 12.10.2023.
//

import UIKit
import AVFoundation




class EditAssetService: EditAssetServiceProtocol{
    func getOnlyOneTrackFromAsset() -> AVPlayerItem?{
  //let myUrl = URL(string: "file:///Users/sametronaer/Library/Developer/CoreSimulator/Devices/6D6D258F-5359-4EA4-A856-DF71EA868090/data/Containers/Data/PluginKitPlugin/D19249A9-E709-49AE-B90B-2B58763B5127/tmp/trim.0647673F-FFB8-46D2-82A3-195013435171.MOV")
        //let myUrl = URL(string: "assets-library://asset/asset.MOV?id=66E35008-D881-4BB4-8108-06EB3ECE15F9&ext=MOV")
        let myUrl = URL(string:   "file:///Users/sametronaer/Library/Developer/CoreSimulator/Devices/6D6D258F-5359-4EA4-A856-DF71EA868090/data/Containers/Data/PluginKitPlugin/D19249A9-E709-49AE-B90B-2B58763B5127/tmp/trim.02EE217C-EF39-4B92-9631-B402F68B5CC8.MOV")
        let asset = AVURLAsset(url: myUrl!)
        //let tracks = try! await asset.load(.tracks)
        let tracks = asset.tracks
        let videoTrack = tracks.last
        let soundTrack = tracks.first
        let composition = AVMutableComposition()
        let compositionTrack = composition.addMutableTrack(withMediaType: soundTrack!.mediaType, preferredTrackID: kCMPersistentTrackID_Invalid)

        try! compositionTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: soundTrack!, at: .zero)
        
        let videoCompositionTrack = composition.addMutableTrack(withMediaType: videoTrack!.mediaType, preferredTrackID: kCMPersistentTrackID_Invalid)

        try! videoCompositionTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: videoTrack!, at: .zero)

        let playerItem = AVPlayerItem(asset: composition)
        
      
        print("Here is and")
        return playerItem
    }
    
}
