//
//  VideoPlayerService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 17.10.2023.
//

import UIKit
import AVFoundation




class VideoPlayerService: VideoPlayerServiceProtocol{
    
    let assetIoService: AssetIOServiceProtocol
    let assetPlayService: AssetPlayServiceProtocol
    let dashboardService: ItemsDashboardServiceProtocol
    let assetEditService: EditAssetServiceProtocol
    let vc: UIViewController
    
    let playerLayer: AVPlayerLayer?
    var id: String? = "VideoPlayer"
    var name: String? = "VideoPlayerService"
    
    
    // This init method created for test purpose
    init(assetIoService: AssetIOServiceProtocol,
         assetPlayService: AssetPlayServiceProtocol,
         dashboardService: ItemsDashboardServiceProtocol,
         vc: UIViewController,
         assetEditService: EditAssetServiceProtocol) {
        self.assetIoService = assetIoService
        self.assetPlayService = assetPlayService
        self.dashboardService = dashboardService
        self.assetEditService = assetEditService
        self.vc = vc
        playerLayer = nil
    }
    
    // This init method used in the app
    init(playerView: UIView, vc: UIViewController){
        self.vc = vc
        self.assetIoService = AssetIOService()
        self.assetPlayService = AssetPlayService(frame: CGRectMake(30, 30, 150, 250))
        self.assetEditService = EditAssetService()
        if let layer = assetPlayService.playerLayer{
            playerView.layer.addSublayer(layer)
            playerLayer = layer
        }else{
            playerLayer = nil
        }
        self.dashboardService = ItemsDashboardService()
        self.dashboardService.subscribe(subscriber: self)
        self.assetIoService.subscribe(subscriber: self)
    }
    
    
    
    func pickVideo(vc: UIViewController, id:String?) {
        assetIoService.pickAsset(controller: vc,
                                 mediaTypes: [.movie, .audio, .image], id: id)
    }
    
    func configTemplateView(configData: String,
                            templateView: TemplateFillScreenView
                            )
    {
        
        if let configModel = VideoComposerConfigParser().getTimelineFromConfig(config: configData){
            let timeline = TimelineFactory(config: configModel, ioService: assetIoService, pickerButtonDelegate: self).getTimeline()
            templateView.setTimeLine(timeLine: timeline)
        }
    }

    

    
    func playCurrentComposition() {
    let currentComposition: AVComposition = getCompostionAssetFromTracksInTheTimeline()
        assetPlayService.playAsset(asset: currentComposition)
    }
    
    private func getCompostionAssetFromTracksInTheTimeline() -> AVComposition{
        let items: [VideoPlayerItemProtocol] = dashboardService.getItems()
        let tracks: [AVAssetTrack]? = items.first?.asset?.tracks
        
        
        let videoTrack = tracks?.last
        let soundTrack = tracks?.first
        
        let composition = AVMutableComposition()
        let compositionSoundTrack = composition.addMutableTrack(withMediaType: soundTrack!.mediaType, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        //try! compositionSoundTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: assets.first!.duration + assets.last!.duration), of: soundTrack!, at: .zero)
        
        // let compositionVideoTrack = composition.addMutableTrack(withMediaType: videoTrack!.mediaType, preferredTrackID: //kCMPersistentTrackID_Invalid)
        
        //try! compositionVideoTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: assets.first!.duration),
        //of: videoTrack!, at: .zero)
        
        //  let compositionImageTrack = composition.addMutableTrack(withMediaType: imageTrack!.mediaType, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        //try! compositionImageTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: assets.first!.duration), of: imageTrack!, at: .zero)
        
        return composition
    }
    
}



extension VideoPlayerService{
    
    private func getVideoTrackOfAsset(asset:AVAsset) -> AVAssetTrack?{
        var track: AVAssetTrack?
        asset.tracks.forEach({
            if $0.mediaType == .video{
                track = $0
            }
        })
        
        return track
    }
    
}


extension VideoPlayerService: ItemDashboardServiceSubscriber{
    func newItemAdded(items: [VideoPlayerItemProtocol], latestItem: VideoPlayerItemProtocol?) {
        print("New asset added")
    }
}


extension VideoPlayerService: AssetIOServiceSubscriberProtocol{
    func didAssetPicked(path: String, id: String?) {
        //  let item : VideoPlayerItemProtocol = VideoPlayerItem(itemType: <#T##AVMediaType#>, timelinePosition: <#T##Float#>)
        //  dashboardService.addNewItemToDashboard(item: path)
    }
}



extension VideoPlayerService: AssetPickerButtonDelegate{
 
    func onTap(id: String?, assetTypes:[UTType]) {
        print("Heyoo")
        assetIoService.pickAsset(controller: vc , mediaTypes: assetTypes, id: id)
    }
    
   
}
