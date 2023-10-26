//
//  VideoComposerParser.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 23.10.2023.
//

import Foundation

class VideoComposerConfigParser{
    
    func getTimelineFromConfig(config: String) -> VideoComposerConfigModel?{
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let config = try decoder.decode(VideoComposerConfigModel.self, from: data)
            print(config)
            return config
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    //Second sytem func
    
    func getSecondSystemConfigObject(config: String) -> SecondConfigModel?{
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let config = try decoder.decode(SecondConfigModel.self, from: data)
            config.sequences.forEach {$0.id = UUID()}
            print(config)
            return config
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

