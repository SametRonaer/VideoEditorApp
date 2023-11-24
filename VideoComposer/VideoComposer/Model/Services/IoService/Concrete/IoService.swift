//
//  IoService.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import UIKit
import AVFoundation

class IoService : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private var subscribers = [IoServiceSubscriber]()
    private var currentTaskOwnerId: UUID?
    
    func subscribe(subscriber: IoServiceSubscriber){
        subscribers.append(subscriber)
    }
    
    func pickAsset(vc:UIViewController, id:UUID){
        currentTaskOwnerId = id
        
        let picker = UIImagePickerController()
        var myMedia: [UTType] = []
        myMedia.append(.movie)
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = try! myMedia.map<String>({ m in
            return m.identifier
        })
        picker.allowsEditing = true
        vc.present(picker, animated: true)
    }
    
}


extension IoService{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        info.forEach({ key, value in
            // Videoda gelen keyler keyler -> UIImagePickerController.InfoKey.mediaType, UIImagePickerController.InfoKey.referenceURL, UIImagePickerController.InfoKey.mediaType
            //TODO add here video, image type check. Now it assume that all picked medias are video
            if key == UIImagePickerController.InfoKey.mediaURL{
                if let asset = getAssetFromPath(path: "\(value)"){
                    subscribers.forEach({
                        $0.newAssetPicked(asset: asset, id: currentTaskOwnerId)
                    })
                }
            }
        })
        currentTaskOwnerId = nil
        picker.dismiss(animated: true)
    }
}
