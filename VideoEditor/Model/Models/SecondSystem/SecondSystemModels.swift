//
//  MediaSequenceModel.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import Foundation
import AVFoundation


struct SecondConfigModel: Codable{
    let sequences: [SecondMediaSquenceModel]
    let audioUrl: String?
}

struct SecondMediaSquenceModel: Codable{
    var assetPath: String?
    let duration: Double
    let type: Int
    var id:UUID? = UUID()
}


struct SecondVideoComposerItem{
    var sequenceId: UUID?
    var track: AVAssetTrack?
    var duration: CMTimeRange?
}
