//
//  KeynoteViewController.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import UIKit
import os

class KeynoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let f = SlideFactory()
        let maxX = view.frame.maxX, maxY = view.frame.maxY
        
        for _ in 0..<4 {
            let newSquare = f.createSquareSlide(maxX: maxX, maxY: maxY)
            Logger().debug("\(newSquare)")
        }
    }
}
