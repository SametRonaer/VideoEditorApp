//
//  VideoComposerView.swift
//  VideoComposer
//
//  Created by Samet Ronaer on 23.11.2023.
//

import UIKit
import AVFoundation

protocol VideoComposerViewDelegate{
    func pickAsset(id:UUID)
    func playComposition()
}

class VideoComposerView: UIView{
    var composerViewConfig: ComposerViewConfigModel!
    var delegate: VideoComposerViewDelegate?
    var videoPlayView = VideoPlayView()
    
    init(composerViewConfig: ComposerViewConfigModel!) {
        super.init(frame: .zero)
        self.composerViewConfig = composerViewConfig
        self.backgroundColor = .white
        configVideoPlayView()
        configPickerButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    func configVideoPlayView(){
        videoPlayView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(videoPlayView)
        videoPlayView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        videoPlayView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        videoPlayView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        videoPlayView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let dummyPlayButton = UIButton()
        dummyPlayButton.translatesAutoresizingMaskIntoConstraints = false
        dummyPlayButton.setTitle("Play", for: .normal)
        dummyPlayButton.backgroundColor = .green
        dummyPlayButton.addTarget(self, action: #selector(dummyPlayCompositionFunction), for: .touchUpInside)
        videoPlayView.addSubview(dummyPlayButton)
        dummyPlayButton.centerXAnchor.constraint(equalTo: videoPlayView.centerXAnchor).isActive = true
        dummyPlayButton.centerYAnchor.constraint(equalTo: videoPlayView.centerYAnchor).isActive = true
    }
    
    func configPickerButtons(){
        
        let dummyPickButton = UIButton()
        dummyPickButton.translatesAutoresizingMaskIntoConstraints = false
        dummyPickButton.setTitle("Pick Asset", for: .normal)
        dummyPickButton.backgroundColor = .black
        dummyPickButton.addTarget(self, action: #selector(dummyPickAssetFunction), for: .touchUpInside)
        addSubview(dummyPickButton)
        dummyPickButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dummyPickButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    @objc func dummyPickAssetFunction(){
        delegate?.pickAsset(id: UUID())
    }
    
    @objc func dummyPlayCompositionFunction(){
        delegate?.playComposition()
    }
}


