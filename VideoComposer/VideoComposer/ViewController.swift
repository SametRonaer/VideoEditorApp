//
//  ViewController.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //let ioService = IoService()
    //let id = UUID()
    var composerService: ComposerService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composerService = ComposerService(vc: self, configDataJson: dummyConfigDataJson)
        view = composerService?.getVideoComposerView()
      //  ioService.subscribe(subscriber: self)
        // Do any additional setup after loading the view.
    }


    @IBAction func pickAsset(){
       // ioService.pickAsset(vc: self, id: id)
    }
}

extension ViewController: IoServiceSubscriber{
    func newAssetPicked(asset: AVAsset, id: UUID?) {
        print("Picked")
    }
    
    
}
