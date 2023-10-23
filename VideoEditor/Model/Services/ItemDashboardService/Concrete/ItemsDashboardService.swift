//
//  AssetDashboardService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 12.10.2023.
//

import AVFoundation
import UIKit



class ItemsDashboardService: ItemsDashboardServiceProtocol{
    
    var name: String? = "AssetDashboardService"
    
    private var subscribers: [ItemDashboardServiceSubscriber] = []
    private var currentItems: [VideoPlayerItemProtocol] = []{
        didSet{
            subscribers.forEach {
                $0.newItemAdded(items: currentItems, latestItem: currentItems.last)
            }
        }
    }
    
    func subscribe(subscriber: ItemDashboardServiceSubscriber){
        subscribers.append(subscriber)
    }
    
    
    func addNewItemToDashboard(item: VideoPlayerItemProtocol) {
        if(item.path == nil){
            return
        }
        if let url = URL(string: item.path!){
            
            let asset = AVURLAsset(url: url)
            var itemWithAsset: VideoPlayerItemProtocol = item
            itemWithAsset.asset = asset
            self.currentItems.append(itemWithAsset)
        }
    }
    
    
    
    func updateAsset() {
       
    }
    
    func removeItemFromDahshboard() {
        
    }
    
    func getItems() -> [VideoPlayerItemProtocol] {
        return currentItems
    }
    
    func getCurrentItem() -> VideoPlayerItemProtocol? {
        return currentItems.last
    }
    
    var id: UUID? = nil
    
}



