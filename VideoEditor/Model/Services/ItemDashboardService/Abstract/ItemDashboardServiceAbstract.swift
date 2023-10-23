//
//  AssetDashboardServiceAbstract.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 20.10.2023.
//

import AVFoundation


protocol ItemsDashboardServiceProtocol{
    func addNewItemToDashboard(item: VideoPlayerItemProtocol)
    func updateAsset()
    func removeItemFromDahshboard()
    func getItems() -> [VideoPlayerItemProtocol]
    func getCurrentItem() -> VideoPlayerItemProtocol?
    func subscribe(subscriber: ItemDashboardServiceSubscriber)
}


protocol ItemDashboardServiceSubscriber{
    func newItemAdded(items: [VideoPlayerItemProtocol], latestItem: VideoPlayerItemProtocol?)
}

