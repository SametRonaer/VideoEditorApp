//
//  TimelineFactory.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 14.10.2023.
//

import UIKit

protocol TimelineElementProtocol{
    var duration: Float?{get set}
}

typealias TimelineViewElement = TimelineElementProtocol & UIView

class TimelineFactory{
    let config: VideoComposerConfigModel
    let ioService: AssetIOServiceProtocol
    let pickerButtonDelegate: AssetPickerButtonDelegate
    init(config: VideoComposerConfigModel,
         ioService: AssetIOServiceProtocol, pickerButtonDelegate: AssetPickerButtonDelegate) {
        self.config = config
        self.ioService = ioService
        self.pickerButtonDelegate = pickerButtonDelegate
    }
    
    
   
 
    
    func getTimeline() -> UIStackView{
        let timeline = UIStackView()
        timeline.axis = .horizontal
        timeline.spacing = 2
        timeline.translatesAutoresizingMaskIntoConstraints = false
        //timeline.distribution = .fillEqually
        
        //TODO fix button width sizes according to duration
        config.mediaSequences.forEach({
            let myView = getTimelineItem(sequence: $0)
            //item.widthAnchor.constraint(equalToConstant: CGFloat( ($0.duration) * 10 )).isActive = true
           // myView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            print($0)
            //let myView = UIView()
            myView.backgroundColor = .green
            myView.delegate = pickerButtonDelegate
            myView.translatesAutoresizingMaskIntoConstraints = false
            timeline.addArrangedSubview(myView)
            myView.widthAnchor.constraint(equalToConstant: 10 * CGFloat($0.duration) ).isActive = true
        })
        
       return timeline
    }
    
    private func getTimelineItem(sequence: MediaSquence) -> AssetPickerButton{
        let id = UUID()
        let pickerButton = AssetPickerButton(duration: sequence.duration, id: id.uuidString , type: sequence.type)
        ioService.subscribe(subscriber: pickerButton)
        return pickerButton
    }
    
}
