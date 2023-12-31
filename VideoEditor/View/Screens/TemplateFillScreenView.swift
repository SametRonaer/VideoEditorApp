//
//  TemplateFillView.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 12.10.2023.
//

import UIKit
import AVFoundation


protocol TemplateFillScreenViewDelegate{
   func playVideo()
}

class TemplateFillScreenView: UIView{
    
    var delegate: TemplateFillScreenViewDelegate?

    
    init() {
        super.init(frame: CGRect.zero)
      
    }
    
    @objc func play(){
        print("Play here")
        delegate?.playVideo()
    }
    
    
    func setTimeLine(timeLine: UIView){
        //addSubview(timeLine)
        //timeLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
      //  timeLine.leadingAnchor.constraint(equalTo: leftAnchor).isActive = true
        //let myView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        addSubview(timeLine)
        
        
        timeLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        timeLine.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        timeLine.heightAnchor.constraint(equalToConstant: 100).isActive = true
        timeLine.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func configButton(){
 
        let playButton: UIButton = UIButton()
        playButton.addTarget(self, action: #selector(play), for: .touchDown)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Play", for: .normal)
        playButton.backgroundColor = .green
        
        addSubview(playButton)
        
        playButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let myPickButton = AssetPickerButton(duration: 40, id: "FirstButton", type: 1)
        myPickButton.setTitle("Pick a video", for: .normal)
        myPickButton.backgroundColor = .lightGray
        //myPickButton.delegate = self
        
        
        
        let myPickButton2 = AssetPickerButton(duration: 20, id: "SecondButton", type: 1)
        myPickButton2.setTitle("Pick a video", for: .normal)
        myPickButton2.backgroundColor =  .lightGray
        //myPickButton2.delegate = self
        
        let myPickButton3 = AssetPickerButton(duration: 20, id: "ThirdButton", type: 1)
        myPickButton3.setTitle("Pick a video", for: .normal)
        myPickButton3.backgroundColor =  .lightGray
        //myPickButton3.delegate = self
       
        //delegate?.subscribePickerButtons(subscribers: [myPickButton, myPickButton2, myPickButton3])
        
        //let timeLine = AssetPickerTimeline(elements: [myPickButton2, myPickButton])
        //let timeLine = TimelineFactory().getTimeline(timelineElements:  [myPickButton, myPickButton2, myPickButton3])
        //addSubview(timeLine)
        
      
      
        //timeLine.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        //timeLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    
    }
    
  
    
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

