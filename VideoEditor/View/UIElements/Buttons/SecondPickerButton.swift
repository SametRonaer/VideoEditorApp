//
//  AssetPickerButton.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 13.10.2023.
//

import UIKit
import AVFoundation


protocol SecondPickerButtonDelegate{
    func onTap(sequence: SecondMediaSquenceModel)
}

class SecondPickerButton: UIButton{
    var delegate: SecondPickerButtonDelegate?
    var sequenceItem : SecondMediaSquenceModel?
    
    

    
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
        if let seq = sequenceItem{
            delegate?.onTap(sequence: seq)
        }
        
        
    }
    
    init(seq: SecondMediaSquenceModel){
        super.init(frame: .zero)
        self.sequenceItem = seq
        addTarget(self, action: #selector(pickAsset), for: .touchDown)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

  
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





extension SecondPickerButton: SecondIoServiceSubscriber{
    func newAssetPicked(path: String, id: UUID?) {
        let isActiveButton : Bool = self.sequenceItem?.id == id
            if isActiveButton{
                pickedFileName = path
            }
    }
    
}

