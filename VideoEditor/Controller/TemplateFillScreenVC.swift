//
//  ViewController.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 12.10.2023.
//

import UIKit
import AVFoundation

class TemplateFillScreenVC: UIViewController {
    
    var videoPlayerService: VideoPlayerService?
    var secondCompeserService: SecondComposerService?
    
    var templateFillScreenView: TemplateFillScreenView!
    
    var timeLineTemplateData: String?
    
    //This init method for testing
    init(videoPlayerService: VideoPlayerService?, view:UIView? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.videoPlayerService = videoPlayerService
       
    }
    
    
    //This init will be used to presentVC in flutter integration
    init(timelineTemplateData: String) {
        super.init(nibName: nil, bundle: nil)
        self.timeLineTemplateData = timelineTemplateData
    }
    
    
    
    //This init method used in app
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.videoPlayerService = VideoPlayerService(playerView: self.view, vc: self)
        self.secondCompeserService = SecondComposerService(configData: DummyData.secondDummyTimeline, vc: self)
        configureTemplateView()
        
    }
    
    
    
    func configureTemplateView(){
       
        templateFillScreenView = TemplateFillScreenView()
        templateFillScreenView.delegate = self
        
       // videoPlayerService?.configTemplateView(configData:  DummyData.dummyTimeline, templateView: templateFillScreenView)
        secondCompeserService?.configTemplateView(templateView: templateFillScreenView)
        view = templateFillScreenView
    }
    
    
}



extension TemplateFillScreenVC: TemplateFillScreenViewDelegate{
    
    @objc func pickVideo(id: String?, assetType: [UTType]) {
        videoPlayerService?.pickVideo(vc: self, id: id)
    }
    

    func subscribePickerButtons(subscribers: [AssetIOServiceSubscriberProtocol]) {
        subscribers.forEach({
            videoPlayerService?.assetIoService.subscribe(subscriber: $0)
        })
    }
    
    func unSubscribePickerButtons(subscribers: [AssetIOServiceSubscriberProtocol]) {
        fatalError("Unimplemented method")
    }
    
    func playVideo() {
        //videoPlayerService?.playCurrentComposition()
        secondCompeserService?.playCurrentComposition()
    }
    
   
    
    
}


extension TemplateFillScreenVC: ItemDashboardServiceSubscriber{
    func newItemAdded(items: [VideoPlayerItemProtocol], latestItem: VideoPlayerItemProtocol?) {
        if let latestItem = latestItem{
            print("Latest item is \(latestItem)")
        }
    }
    
    
    
    
}









/*
import UIKit
import AVFoundation

class TemplateFillScreenVC: UIViewController {
    
    var assetIOService: AssetIOServiceProtocol?
    var assetEditService: EditAssetServiceProtocol?
    var assetDashboardService: AssetDashboardServiceProtocol?
    var assetPlayService: AssetPlayServiceProtocol?
    
    var templateFillScreenView: TemplateFillScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTemplateView()
        setupServices()
        
    }
    
    func setupServices(){
        assetIOService = AssetIOService()
        assetEditService = EditAssetService()
        assetPlayService = AssetPlayService(frame: CGRectMake(30, 30, 150, 250))
        
        if let playerLayer = assetPlayService?.playerLayer{
            templateFillScreenView.layer.addSublayer(playerLayer)
        }
        
        assetDashboardService = AssetDashboardService()
        assetDashboardService?.subscribe(subscriber: self)
        
        assetIOService?.subscribe(subscriber: assetDashboardService as! AssetIOServiceSubscriberProtocol)
        
        templateFillScreenView.configButton()
        
    }
    
    func configureTemplateView(){
        templateFillScreenView = TemplateFillScreenView()
        templateFillScreenView.backgroundColor = .white
        templateFillScreenView.delegate = self
      
        view = templateFillScreenView
    }
    
    
}



extension TemplateFillScreenVC: TemplateFillScreenViewDelegate{

    func subscribePickerButtons(subscribers: [AssetIOServiceSubscriberProtocol]) {
        subscribers.forEach({
            assetIOService?.subscribe(subscriber: $0)
        })
    }
    
    func unSubscribePickerButtons(subscribers: [AssetIOServiceSubscriberProtocol]) {
        fatalError("Unimplemented method")
    }
    
    func playVideo() {
        if let asset = assetDashboardService?.getCurrentAsset() {
            assetPlayService?.playAsset(asset: asset)
        }
    }
    
    @objc func pickVideo(id: UUID) {
        assetIOService?.pickAsset(controller: self,
                                  mediaTypes: [.movie, .audio, .image], id: id)
        
    }
    
    
}


extension TemplateFillScreenVC: AssetDashboardServiceSubscriber{
    func newAssetAdded(assets: [AVAsset], latestAsset: AVAsset?) {
        if let latestAsset = latestAsset{
            print("Latest asset is \(latestAsset)")
        }
    }
    
    
}

*/
