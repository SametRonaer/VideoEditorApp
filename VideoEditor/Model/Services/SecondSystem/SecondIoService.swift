//
//  SecondIoService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import UIKit
import AVFoundation


protocol SecondIoServiceSubscriber{
    func newAssetPicked(path: String, id: UUID?)
}


class SecondIoService : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var taskOwnerIds: [UUID] = .init()
    private var subscribers: [SecondIoServiceSubscriber] = .init()
    
    func subscribe(subscriber: SecondIoServiceSubscriber){
        subscribers.append(subscriber)
    }
    
    func pickAsset(controller: UIViewController, sequence: SecondMediaSquenceModel) {
     
        let picker = UIImagePickerController()
        //TODO fix here
        //var myMedia: [UTType] = getMediaTypes(typeId: sequence.type)
        //myMedia.append(.video)
        var myMedia: [UTType] = []
        myMedia.append(.movie)
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = try! myMedia.map<String>({ m in
            return m.identifier
        })
        picker.allowsEditing = false
        if let id = sequence.id{
            taskOwnerIds.append(id)
            controller.present(picker, animated: true)
            print("Boo")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        info.forEach({ key, value in
            // Videoda gelen keyler keyler -> UIImagePickerController.InfoKey.mediaType, UIImagePickerController.InfoKey.referenceURL, UIImagePickerController.InfoKey.mediaType
            //TODO add here video, image type check. Now it assume that all picked medias are video
            if key == UIImagePickerController.InfoKey.mediaURL{
                
                subscribers.forEach({
                    $0.newAssetPicked(path: "\(value)", id: taskOwnerIds.last)
                    
                })
                
                taskOwnerIds.removeLast()
            }
            
        })
        
        
        
        picker.dismiss(animated: true)
    }
    
}





