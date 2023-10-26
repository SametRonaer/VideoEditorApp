//
//  SecondComposerService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import UIKit
import AVFoundation


class SecondComposerService{
    let configData: String
    let vc: UIViewController
    
    private var dashboardService: SecondDashboardService?
    private var ioService: SecondIoService = SecondIoService()
    
    init(configData: String, vc: UIViewController) {
        self.vc = vc
        self.configData = configData
        initializeDashboardService()
        ioService.subscribe(subscriber: self)
        
        
    }
    
    private func initializeDashboardService(){
        if let config = VideoComposerConfigParser().getSecondSystemConfigObject(config: configData){
            dashboardService = SecondDashboardService(composerConfig: config)
        }
    }
}


extension SecondComposerService: SecondIoServiceSubscriber{
    func newAssetPicked(path: String, id: UUID?) {
        if var currentItem =  dashboardService!.composerConfig.sequences.first { item in
            return item.id == id
        }{
            currentItem.assetPath = path
            //TODO add here to image video seperator. Now it assume picked asset always video
            
            if let asset = getAssetFromPath(path: path){
                var item = SecondVideoComposerItem()
                item.track = getVideoTrackOfAsset(asset: asset)
                item.sequenceId = currentItem.id
                item.duration = getComposerItemTimeRange(duration: currentItem.duration)
                dashboardService?.addNewComposerItemToDashboard(item: item)
            }
               
                
            
        }
    }
    
}

extension SecondComposerService: SecondPickerButtonDelegate{
    func onTap(sequence: SecondMediaSquenceModel) {
        ioService.pickAsset(controller: vc, sequence: sequence)
    }
    
    
}
