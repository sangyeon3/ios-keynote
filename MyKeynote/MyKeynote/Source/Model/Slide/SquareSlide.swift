//
//  SquareSlide.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

final class SquareSlide: Slide {
    
    required init(id: String, width: Double, color: RGBColor, alpha: SYAlpha) {
        super.init(id: id, width: width, color: color, alpha: alpha)
        self.size = SYSize(width: width, height: width)
    }
    
    override var description: String {
        "\(Self.self) (\(id)), Side:\(size.width), \(backgroundColor), Alpha: \(alpha)"
    }
}
