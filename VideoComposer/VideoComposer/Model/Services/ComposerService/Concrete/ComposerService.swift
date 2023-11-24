//
//  ComposerService.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import UIKit
import AVFoundation

class ComposerService{
    let vc: UIViewController!
    let configDataJson: String!
    
    private var configData: ComposerConfigModel?
    private var composerViewConfigModel: ComposerViewConfigModel?
    
    private var ioService: IoService?
    private var dashboardService: DashboardService?
    private var playService: PlayService?
    
    private var videoComposerView: VideoComposerView?
    
    init(vc: UIViewController!, configDataJson: String!) {
        self.vc = vc
        self.configDataJson = configDataJson
        parseConfigData()
        configServices()
        subscribeServices()
         
    }
    
    private func parseConfigData(){
        let parser = VideoComposerConfigParser()
        self.configData = parser.parseConfigData(config: self.configDataJson)
        if self.configData != nil {
            self.composerViewConfigModel = parser.getComposerConfigViewModel(model: self.configData!)
        }
    }
    
    private func configServices(){
        ioService = IoService()
        playService = PlayService()
        if composerViewConfigModel != nil{
            dashboardService = DashboardService(composerViewConfig: composerViewConfigModel)
        }
    }
    
    private func subscribeServices(){
        ioService?.subscribe(subscriber: self)
    }
    
    func getVideoComposerView() -> VideoComposerView{
        videoComposerView = VideoComposerView(composerViewConfig: composerViewConfigModel)
        videoComposerView?.delegate = self
        return videoComposerView!
    }
    
}


extension ComposerService: IoServiceSubscriber{
    func newAssetPicked(asset: AVAsset, id: UUID?) {
        dashboardService?.addAssetToConfig(asset: asset, id: id)
    }
}

extension ComposerService: VideoComposerViewDelegate{
    func playComposition() {
        print("Played")
        if let currentComposition = dashboardService?.getCurrentComposition() , let playerLayer = videoComposerView?.videoPlayView.playerLayer{
            playService?.playCurrentComposition(composition: currentComposition, playerLayer: playerLayer)
        }
        
    }
    
    func pickAsset(id: UUID) {
        ioService?.pickAsset(vc: vc, id: id)
    }
    
    
}
