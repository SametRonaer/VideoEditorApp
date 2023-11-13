//
//  SecondDashboardService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import Foundation

protocol SecondDashboardServiceSubscriber{
    func didItemAdded(item: SecondVideoComposerItem)
}

class SecondDashboardService{
    let composerConfig: SecondConfigModel
    var composerItems: [SecondVideoComposerItem] = .init()
    
    private var subscribers: [SecondDashboardServiceSubscriber] = []
    
    func addSubscriber(subscriber: SecondDashboardServiceSubscriber){
        subscribers.append(subscriber)
    }
    
    
    
    init(composerConfig: SecondConfigModel) {
        self.composerConfig = composerConfig
    }
    
    func addNewComposerItemToDashboard(item: SecondVideoComposerItem){
        composerItems.append(item)
        subscribers.forEach {
            $0.didItemAdded(item: item)
        }
    }
    
}
