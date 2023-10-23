//
//  VideoComposerConfigModel.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 23.10.2023.
//

import Foundation


struct VideoComposerConfigModel: Codable {
    
    let mediaSequences: [MediaSquence]
    let clipSoundUrl: String
    
    
}

struct MediaSquence: Codable{
    let duration: Float
    let type: Int
}
