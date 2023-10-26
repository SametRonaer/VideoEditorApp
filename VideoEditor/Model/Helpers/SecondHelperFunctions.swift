//
//  SecondHelperFunctions.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import Foundation
import AVFoundation


func getMediaTypes(typeId: Int) -> [UTType] {
    var types: [UTType] = .init()
    if typeId == 1{
        types.append(.movie)
        return types
    }else if typeId == 2 {
        types.append(.image)
        return types
    }else if typeId == 2 {
        types.append(.image)
        types.append(.video)
        return types
    }
    else{
        return types
    }
}

func getAssetFromPath(path: String) -> AVURLAsset?{
    if let url = URL(string: path){
        let asset = AVURLAsset(url: url)
        return asset
    }
    return nil
}

func getVideoTrackOfAsset(asset: AVAsset) -> AVAssetTrack?{
    if let videoTrack = asset.tracks.first(where: { track in
        return track.mediaType == .video
    }){
        return videoTrack
    }
    return nil
}

func getComposerItemTimeRange(duration: Double) -> CMTimeRange{
    let duration = CMTimeRange(start: .zero, duration: CMTime(seconds: duration, preferredTimescale: 1))
    return duration
}


