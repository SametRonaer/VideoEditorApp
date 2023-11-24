//
//  HelperFunctions.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import AVFoundation

func getAssetFromPath(path: String) -> AVURLAsset?{
    if let url = URL(string: path){
        let asset = AVURLAsset(url: url)
        return asset
    }
    return nil
}
