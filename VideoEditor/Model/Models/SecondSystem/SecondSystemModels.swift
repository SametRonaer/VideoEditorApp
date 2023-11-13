//
//  MediaSequenceModel.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import UIKit
import AVFoundation


class SecondConfigModel: Codable{
    let sequences: [SecondMediaSquenceModel]
    let audioUrl: String?
}

class SecondMediaSquenceModel: Codable{
    var assetPath: String?
    let duration: Double
    let type: Int
    var id:UUID? = UUID()
}


class SecondVideoComposerItem{
    var sequenceId: UUID?
    var track: AVAssetTrack?
    var duration: CMTimeRange?
    var thumbnail: UIImage?
}
