//
//  AssetIoServiceAbstract.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 20.10.2023.
//

import UIKit
import AVFoundation

protocol AssetIOServiceProtocol{
    func pickAsset(controller: UIViewController, mediaTypes: [UTType], id:String?)
    func subscribe(subscriber: AssetIOServiceSubscriberProtocol)
    
}

protocol AssetIOServiceSubscriberProtocol{
    func didAssetPicked(path: String, id:String?)
    var id: String?{get set}
    var name: String?{get set}
}
