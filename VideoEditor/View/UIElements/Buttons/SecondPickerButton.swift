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
    
    
    func addDurationLabel(){
        let durationView = UILabel()
        durationView.backgroundColor = #colorLiteral(red: 0.9623988271, green: 0.9691058993, blue: 0.981377542, alpha: 1)
        durationView.translatesAutoresizingMaskIntoConstraints = false
        durationView.text = "\(sequenceItem!.duration)"
        durationView.textAlignment = .center
        durationView.font = .systemFont(ofSize: 12)
        durationView.layer.cornerRadius = 10.0
        durationView.layer.zPosition = 1
        durationView.layer.masksToBounds = true
        durationView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        durationView.layer.borderWidth = 1
        addSubview(durationView)
        durationView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        durationView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        durationView.topAnchor.constraint(equalTo: topAnchor, constant: -20).isActive = true
        durationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    func addPlusIcon(){
        if let plusImage = UIImage(named: "plus"){
            let plusImageView = UIImageView(image: plusImage)
            plusImageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(plusImageView)
            plusImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            plusImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            plusImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
    
     func addDashedRect() {
         if let dashedRectImage = UIImage(named: "dashedRecter"){
             dashedRectImage.withTintColor(.blue)
             let dashedRectImageView = UIImageView(image: dashedRectImage)
             
             dashedRectImageView.translatesAutoresizingMaskIntoConstraints = false
             addSubview(dashedRectImageView)
             //dashedRectImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
             //dashedRectImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            // dashedRectImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
             //dashedRectImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
             dashedRectImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
             dashedRectImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
             dashedRectImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
             dashedRectImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
         }
         
    }
    
    func addThumbnailImage(image:UIImage){
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.zPosition = 0
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
    }
    
    private var pickedFileName: String?{
        didSet{
            //setButtonState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
    }
    
    override func didAddSubview(_ subview: UIView) {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        //setButtonState()
    }
    
    @objc private func pickAsset(){
        print("Something")
        DispatchQueue.main.async  { [self] in
            if let seq = sequenceItem{
                delegate?.onTap(sequence: seq)
            }
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

extension SecondPickerButton: SecondDashboardServiceSubscriber{
    func didItemAdded(item: SecondVideoComposerItem) {
        if sequenceItem?.id == item.sequenceId{
            if let image = item.thumbnail{
                addThumbnailImage(image: image)
            }
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

