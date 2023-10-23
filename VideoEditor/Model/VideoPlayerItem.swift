//
//  VideoPlayerItem.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 20.10.2023.
//

import AVFoundation

protocol VideoPlayerItemProtocol{
    var asset:AVAsset?{get set}
    var itemType: AVMediaType{get set}
    var startTime: Float?{get set}
    var endTime: Float?{get set}
    var timelinePosition: Float {get set}
    var itemTitle: String?{get set}
    var path: String?{get set}
    var totalDuration: Float?{get}
    var trackOfAssetAccordingToMediaType: AVAssetTrack?{get}
}

class VideoPlayerItem: VideoPlayerItemProtocol{
  
 
    
    var asset: AVAsset?
    
    var itemType: AVMediaType
    
    var startTime: Float?
    
    var endTime: Float?
    
    var timelinePosition: Float = 0.0
    
    var itemTitle: String?
    
    var path: String?
    
    
    init(asset: AVAsset? = nil, itemType: AVMediaType, startTime: Float? = nil, endTime: Float? = nil, timelinePosition: Float, itemTitle: String? = nil, path: String? = nil) {
        self.asset = asset
        self.itemType = itemType
        self.startTime = startTime
        self.endTime = endTime
        self.timelinePosition = timelinePosition
        self.itemTitle = itemTitle
        self.path = path
    }
    
    
    var totalDuration: Float?{
        if(startTime != nil && endTime != nil){
            return endTime! - startTime!
        }
        return nil
    }
    
    var trackOfAssetAccordingToMediaType: AVAssetTrack?{
        if let track = asset?.tracks(withMediaType: itemType).first{
            return track
        }else{
            debugPrint("Track could not find as a current media type")
            return nil
        }
        
        
    }
    
    
   

}
