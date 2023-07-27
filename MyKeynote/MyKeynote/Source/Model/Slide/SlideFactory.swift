//
//  SlideFactory.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

final class SlideFactory: SlideCreatable {
    
    func makeSquareSlide() -> SquareSlide {
        let id = SlideID.randomId()
        let side = Double(Int.random(in: 100...400))
        let color = RGBColor.randomRGB()
        let alpha = SYAlpha.randomAlpha()
        
        return SquareSlide(id: id, side: side, color: color, alpha: alpha)
    }
    
    func makePhotoSlide() -> PhotoSlide {
        let id = SlideID.randomId()
        return PhotoSlide(id: id)
    }
}
