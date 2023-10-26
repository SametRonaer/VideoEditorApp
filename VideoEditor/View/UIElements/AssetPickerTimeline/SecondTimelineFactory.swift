//
//  TimelineFactory.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 14.10.2023.
//

import UIKit


class SecondTimelineFactory{
    let config: SecondConfigModel
    let ioService: SecondIoService
    let pickerButtonDelegate: SecondPickerButtonDelegate
    init(config: SecondConfigModel,
         ioService: SecondIoService, pickerButtonDelegate: SecondPickerButtonDelegate) {
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
        config.sequences.forEach({
            let myView = getPickerButton(sequence: $0)
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
    
    private func getPickerButton(sequence: SecondMediaSquenceModel) -> SecondPickerButton{
        let id = UUID()
        let pickerButton = SecondPickerButton(seq: sequence)
        ioService.subscribe(subscriber: pickerButton)
        return pickerButton
    }
    
}
