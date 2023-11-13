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
    let dashboardService: SecondDashboardService
    let pickerButtonDelegate: SecondPickerButtonDelegate
    init(config: SecondConfigModel,
         ioService: SecondIoService,
         pickerButtonDelegate: SecondPickerButtonDelegate,
         dashboardService: SecondDashboardService) {
        self.config = config
        self.ioService = ioService
        self.pickerButtonDelegate = pickerButtonDelegate
        self.dashboardService = dashboardService
    }
    
    
   
 
    
    func getTimeline() -> UIStackView{
        let timeline = UIStackView()
        timeline.axis = .horizontal
        timeline.spacing = 2
        timeline.translatesAutoresizingMaskIntoConstraints = false
        timeline.distribution = .equalSpacing
        //timeline.spacing = 8.0
        
        //TODO fix button width sizes according to duration
        config.sequences.forEach({
            let pickerButton = getPickerButton(sequence: $0)
            //item.widthAnchor.constraint(equalToConstant: CGFloat( ($0.duration) * 10 )).isActive = true
           // myView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            //let myView = UIView()
            //pickerButton.backgroundColor = .green
            pickerButton.delegate = pickerButtonDelegate
            //pickerButton.addDashedBorder()
            pickerButton.layer.borderColor = UIColor.lightGray.cgColor
            pickerButton.layer.borderWidth = 1
            pickerButton.layer.zPosition = -1
            pickerButton.translatesAutoresizingMaskIntoConstraints = false
            
            timeline.addArrangedSubview(pickerButton)
            pickerButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
            pickerButton.addDurationLabel()
            pickerButton.addPlusIcon()
           // pickerButton.addDashedRect()
            //pickerButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
        })
        
       return timeline
    }
    
    private func getPickerButton(sequence: SecondMediaSquenceModel) -> SecondPickerButton{
        let id = UUID()
        let pickerButton = SecondPickerButton(seq: sequence)
       // pickerButton.addDashedBorder()
        ioService.subscribe(subscriber: pickerButton)
        dashboardService.addSubscriber(subscriber: pickerButton)
        return pickerButton
    }
    
}
