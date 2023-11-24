//
//  ComposerConfigModel.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import Foundation

class ComposerConfigModel: Codable{
    let soundUrl: String
    let sequences: [SequenceModel]
    
    init(soundUrl: String, sequences: [SequenceModel]) {
        self.soundUrl = soundUrl
        self.sequences = sequences
    }
}

class SequenceModel: Codable{
    let duration: Float
    let type:Int
    
    init(duration: Float, type: Int) {
        self.duration = duration
        self.type = type
    }
}
