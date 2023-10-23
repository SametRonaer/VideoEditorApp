//
//  VideoPlayerServiceAbstract.swift
//  VideoEditor
//
//  Created by Samet Ronaer on 20.10.2023.
//

import UIKit


protocol VideoPlayerServiceProtocol{
    
    func playCurrentComposition()
    func pickVideo(vc: UIViewController, id:String?)
}
