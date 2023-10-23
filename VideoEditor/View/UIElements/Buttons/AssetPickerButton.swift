//
//  AssetPickerButton.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 13.10.2023.
//

import UIKit
import AVFoundation


protocol AssetPickerButtonDelegate{
  func onTap(id: String?, assetTypes:[UTType])
}

class AssetPickerButton: UIButton{
    var id: String?
    var duration: Float?
    var delegate: AssetPickerButtonDelegate?
    var name: String? = "AssetPickerButton"
    private var mediaTypes: [UTType] = []
    
    private var pickedFileName: String?{
        didSet{
            setButtonState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
    }
    
    override func didAddSubview(_ subview: UIView) {
        setButtonState()
    }
    
    @objc private func pickAsset(){
        
        delegate?.onTap(id: id ?? "", assetTypes: mediaTypes)
        
    }
    
    init(duration: Float?, id: String?, type: Int){
        super.init(frame: .zero)
        self.duration = duration
        self.id = id ?? ""
        self.mediaTypes = getMediaType(type: type)
        addTarget(self, action: #selector(pickAsset), for: .touchDown)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func getMediaType(type:Int) -> [UTType]{
        if(type == 1){
            return [.video]
        }else if(type == 2){
            return [.image]
        }else if(type == 3){
            return [.video, .image]
        }
        return [.audio]
    }
  
    
    
}


extension AssetPickerButton{
    private func setButtonState(){
        let isPicked: Bool = pickedFileName != nil
        if isPicked{
            backgroundColor = .brown
            setTitle(pickedFileName!, for: .normal)
        }else{
            backgroundColor = .gray
            setTitle("Pick asset", for: .normal)
        }
    }
}


extension AssetPickerButton:TimelineElementProtocol{
   
    
    
}

extension AssetPickerButton: AssetIOServiceSubscriberProtocol{
    func didAssetPicked(path: String, id: String?) {
        let isActiveButton : Bool = self.id == id
            if isActiveButton{
                pickedFileName = path
            }
    }
}
