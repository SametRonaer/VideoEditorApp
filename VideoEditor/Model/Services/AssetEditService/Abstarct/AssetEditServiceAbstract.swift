//
//  AssetEditServiceAbstract.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 20.10.2023.
//

import AVFoundation


protocol EditAssetServiceProtocol{
    func getOnlyOneTrackFromAsset()  -> AVPlayerItem?
}
