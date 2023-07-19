//
//  SlideFactory.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

final class SlideFactory: SlideCreatable {
    
    func createSquareSlide(maxX: Double, maxY: Double) -> SquareSlide {
        let id = SlideID.randomId()
        let index = SquareSlide.fetchNextIndex()
        let point = Point(x: 4, y: 6)
        let backgroundColor = RGB.randomRGB()
        let alpha = Alpha.randomAlpha()
        let side = Int.random(in: 10...1000)
        
        return SquareSlide(id: id, index: index, point: point, backgroundColor: backgroundColor, alpha: alpha, side: side)
    }
}
