//
//  IoServiceAbstract.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import AVFoundation

protocol IoServiceSubscriber{
    func newAssetPicked(asset: AVAsset, id:UUID?)
}
