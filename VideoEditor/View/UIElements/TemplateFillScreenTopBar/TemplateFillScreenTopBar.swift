//
//  TemplateFillScreenTopBar.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 11.11.2023.
//

import UIKit

class TemplateFillScreenTopBar: UIView{
   
    private var backButton: UIButton?
    private var likeButton: UIButton?
    private var musicButton: UIButton?
    private var saveButton: UIButton?
    private var editButton: UIButton?
    private let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
    
    func configureButtons(){
        addBackButton()
        addEditButton()
        addSaveButton()
        addMusicButton()
        addLikeButton()
    }
    
    private func addBackButton(){
        backButton = UIButton()
        backButton!.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(systemName: "chevron.backward", withConfiguration: largeConfig)
        backButton!.setImage(icon, for: .normal)
        backButton!.tintColor = .white
        backButton!.addTarget(self, action: #selector(onTapBackButton), for: .touchUpInside)
        
        addSubview(backButton!)
        backButton!.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backButton!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func addEditButton(){
        editButton = UIButton()
        editButton!.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(systemName: "square.and.pencil", withConfiguration: largeConfig)
        editButton!.setImage(icon, for: .normal)
        editButton!.tintColor = .white
        editButton!.addTarget(self, action: #selector(onTapEditButton), for: .touchUpInside)
        
        addSubview(editButton!)
        editButton!.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        editButton!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func addSaveButton(){
        saveButton = UIButton()
        saveButton!.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(systemName: "square.and.arrow.down", withConfiguration: largeConfig)
        saveButton!.tintColor = .white
        saveButton!.setImage(icon, for: .normal)
        saveButton!.addTarget(self, action: #selector(onTapSaveButton), for: .touchUpInside)
        
        addSubview(saveButton!)
        saveButton!.trailingAnchor.constraint(equalTo: editButton!.leadingAnchor, constant: -12).isActive = true
        saveButton!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func addMusicButton(){
        musicButton = UIButton()
        musicButton!.tintColor = .white
        musicButton!.translatesAutoresizingMaskIntoConstraints = false
        musicButton!.tintColor = .white
        let icon = UIImage(systemName: "music.note", withConfiguration: largeConfig)
        musicButton!.setImage(icon, for: .normal)
        musicButton!.addTarget(self, action: #selector(onTapMusicButton), for: .touchUpInside)
        
        addSubview(musicButton!)
        musicButton!.trailingAnchor.constraint(equalTo: saveButton!.leadingAnchor, constant: -12).isActive = true
        musicButton!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func addLikeButton(){
        likeButton = UIButton()
        likeButton!.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(systemName: "heart", withConfiguration: largeConfig)
        likeButton!.tintColor = .white
        likeButton!.setImage(icon, for: .normal)
        likeButton!.addTarget(self, action: #selector(onTapLikeButton), for: .touchUpInside)
        
        addSubview(likeButton!)
        likeButton!.trailingAnchor.constraint(equalTo: musicButton!.leadingAnchor, constant: -12).isActive = true
        likeButton!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

//MARK: Button Actions
extension TemplateFillScreenTopBar{
    
    @objc private func onTapBackButton(){
        print("Back button")
    }
    @objc private func onTapLikeButton(){
        print("Like button")
    }
    @objc private func onTapMusicButton(){
        print("Music button")
    }
    @objc private func onTapSaveButton(){
        print("Save button")
    }
    @objc private func onTapEditButton(){
        print("Edit button")
    }
    
    
}
