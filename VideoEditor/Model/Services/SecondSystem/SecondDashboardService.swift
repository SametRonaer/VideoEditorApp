//
//  SecondDashboardService.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 26.10.2023.
//

import Foundation


class SecondDashboardService{
    let composerConfig: SecondConfigModel
    private var composerItems: [SecondVideoComposerItem] = .init()
    init(composerConfig: SecondConfigModel) {
        self.composerConfig = composerConfig
    }
    
    func addNewComposerItemToDashboard(item: SecondVideoComposerItem){
        composerItems.append(item)
    }
    
}
