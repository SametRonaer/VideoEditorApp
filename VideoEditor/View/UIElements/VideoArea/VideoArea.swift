//
//  VideoArea.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 12.11.2023.
//

import UIKit
import AVFoundation

protocol VideoAreaDelegate{
    func playVideo()
    func stopVideo()
}

class VideoArea: UIView{
    var delegate: VideoAreaDelegate?
    
    private var isPlaying: Bool = false
    private var playButton: UIButton?
    private var playButtonImage: UIImage?
    
    private var sliderMinValue: Float = 0.0
    private var sliderMaxValue: Float = 60.0
    
    let maxTime = UILabel()
    let minTime = UILabel()
    
    private let playImage = "play.fill"
    private let pauseImage = "pause.fill"
    
    init(){
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.addTopBar()
        self.addTimeBar()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func addTimeBar(){
        
        let sliderArea = getSliderArea()
        let playButtonArea = getPlayButtonArea()
        let timeBar = UIStackView(arrangedSubviews: [playButtonArea ,sliderArea])
        timeBar.axis = .vertical
        timeBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeBar)
        
        timeBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        timeBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        timeBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        let minMark = sliderAreaMark
        let maxMark = sliderAreaMark
        let middleMark = sliderAreaMark
        
        sliderArea.addSubview(minMark)
        sliderArea.addSubview(maxMark)
        sliderArea.addSubview(middleMark)
        
        minMark.leadingAnchor.constraint(equalTo: sliderArea.leadingAnchor).isActive = true
        minMark.centerYAnchor.constraint(equalTo: sliderArea.centerYAnchor).isActive = true
        maxMark.trailingAnchor.constraint(equalTo: sliderArea.trailingAnchor).isActive = true
        maxMark.centerYAnchor.constraint(equalTo: sliderArea.centerYAnchor).isActive = true
        middleMark.centerYAnchor.constraint(equalTo: sliderArea.centerYAnchor).isActive = true
        middleMark.centerXAnchor.constraint(equalTo: sliderArea.centerXAnchor).isActive = true
        
    }
    
    var sliderAreaMark: UIView{
        let sliderMark = UIView()
        sliderMark.backgroundColor = .white
        sliderMark.translatesAutoresizingMaskIntoConstraints = false
        sliderMark.heightAnchor.constraint(equalToConstant: 10).isActive = true
        sliderMark.widthAnchor.constraint(equalToConstant: 3).isActive = true
        return sliderMark
    }
    
    private func getSliderArea() -> UISlider{

        let sliderArea = UISlider()
        sliderArea.thumbTintColor = .white
        sliderArea.translatesAutoresizingMaskIntoConstraints = false
        sliderArea.minimumValue = sliderMinValue
        sliderArea.maximumValue = sliderMaxValue
        sliderArea.minimumTrackTintColor = .white
        sliderArea.maximumTrackTintColor = .gray
        sliderArea.addTarget(self, action: #selector(onSliderValueChanged), for: .valueChanged)
        
        
        return sliderArea
    }
    
    
    private func getPlayButtonArea() -> UIStackView{
        
        
        
        minTime.text = "\(sliderMinValue)"
        minTime.textColor = .white
        minTime.font = .systemFont(ofSize: 14,weight: .semibold)
        minTime.widthAnchor.constraint(equalToConstant: 40).isActive = true
      
        maxTime.text = "\(sliderMaxValue)"
        maxTime.textColor = .white
        maxTime.font = .systemFont(ofSize: 14, weight: .semibold)
        
        playButton = UIButton()
        playButton!.backgroundColor = .white
        playButton!.translatesAutoresizingMaskIntoConstraints = false
        playButton!.layer.cornerRadius = 20
        playButton!.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton!.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        playButtonImage = UIImage(systemName: playImage)
        playButton!.tintColor = .black
        playButton!.setImage(playButtonImage!, for: .normal)
        playButton!.addTarget(self, action: #selector(onTapPlayButton), for: .touchUpInside)
        
        
        let stack = UIStackView(arrangedSubviews: [minTime, playButton!, maxTime])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        return stack
    }
    
    private func addTopBar(){
        let topBar = TemplateFillScreenTopBar()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topBar)
        topBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        topBar.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        topBar.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -5).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        topBar.configureButtons()
    }
    
    private func addPlayerLayer(){
        
    }
    
    override class var layerClass: AnyClass{
        return AVPlayerLayer.self
    }
    
    
}


//MARK: Actions
extension VideoArea{
    @objc private func onTapPlayButton(){
        var image: UIImage!
        isPlaying = !isPlaying
        if isPlaying{
            image = UIImage(systemName: pauseImage)
            delegate?.playVideo()
        }else{
            image = UIImage(systemName: playImage)
            delegate?.stopVideo()
        }
        playButton?.setImage(image, for: .normal)
    }
    
    @objc private func onSliderValueChanged(sender:UISlider){
        
        minTime.text = "\(round(sender.value * 10)/10)"
    }
}
