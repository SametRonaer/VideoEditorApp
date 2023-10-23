//
//  AssetIOService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 12.10.2023.
//

import UIKit
import AVFoundation


class AssetIOService:NSObject,  AssetIOServiceProtocol,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    var subscribers: [AssetIOServiceSubscriberProtocol] = []{
        didSet{
            if oldValue.count > subscribers.count{
                debugPrint("AssetIOService: Subscriber removed, totalSubscriber = \(subscribers.count) ")
                debugPrint("AssetIOService: ----------------------------------------------")
            }else{
                debugPrint("AssetIOService: Subscriber added, totalSubscriber = \(subscribers.count), new subscriber = \(String(describing: subscribers.last!.name ?? ""))")
                debugPrint("AssetIOService: ----------------------------------------------")
            }
            
        }
    }
    
    func subscribe(subscriber: AssetIOServiceSubscriberProtocol) {
        subscribers.append(subscriber)
    }
    
    
    private var picker: UIImagePickerController!
    
    private var taskOwnerIds : [String] = []
    
    func pickAsset(controller: UIViewController, mediaTypes: [UTType], id:String?) {
        picker = UIImagePickerController()
        var myMedia: [UTType] = []
        myMedia.append(.movie)
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = try! myMedia.map<String>({ m in
            return m.identifier
        })
        picker.allowsEditing = false
        if(id != nil){
            taskOwnerIds.append(id!)
        }
        
       
       
            controller.present(self.picker, animated: true)
       
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
                   print("Edited Image Picked")
               }

               if let image = info[.originalImage] as? UIImage {
                   print("Original Image Picked")
               } else {
                   print("Other source")
                   info.forEach({ key, value in
                       // Videoda gelen keyler keyler -> UIImagePickerController.InfoKey.mediaType, UIImagePickerController.InfoKey.referenceURL, UIImagePickerController.InfoKey.mediaType
                       if key == UIImagePickerController.InfoKey.mediaURL{
                           subscribers.forEach({
                               $0.didAssetPicked(path: "\(value)", id: taskOwnerIds.last)
                              
                           })
                           
                           taskOwnerIds.removeLast()
                       }
                       
                   })
               }
      
        
        picker.dismiss(animated: true)
    }
    
    
    
    
    
}

