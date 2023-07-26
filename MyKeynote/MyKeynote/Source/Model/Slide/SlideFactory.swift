//
//  SlideFactory.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

final class SlideFactory: SlideCreatable {
    
    func makeSlide<T: Slide>(type: T.Type) -> T {
        let id = SlideID.randomId()
        let width = Double(Int.random(in: 100...400))
        let color = RGBColor.randomRGB()
        let alpha = SYAlpha.randomAlpha()

        return T(
            id: id,
            width: width,
            color: color,
            alpha: alpha
        )
    }
}
