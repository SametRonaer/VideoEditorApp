//
//  ComposerViewConfigModel.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import AVFoundation

class ComposerViewConfigModel{
    var sequences: [ComposerViewConfigSequenceModel]
    var soundUrl: String
    
    init(sequences: [ComposerViewConfigSequenceModel], soundUrl: String) {
        self.sequences = sequences
        self.soundUrl = soundUrl
    }
}

class ComposerViewConfigSequenceModel{
    var asset: AVAsset?
    let id = UUID()
    var duration: Float
    let type: Int
    
    init(asset: AVAsset? = nil, duration: Float, type: Int) {
        self.asset = asset
        self.duration = duration
        self.type = type
    }
}
