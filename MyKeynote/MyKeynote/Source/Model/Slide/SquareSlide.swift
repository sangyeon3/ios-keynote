//
//  SquareSlide.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/27.
//

import Foundation

final class SquareSlide: BaseSlide, Colorful, AlphaAdaptable {

    var id: String
    private(set) var size: SYSize
    private(set) var color: RGBColor
    private(set) var alpha: SYAlpha
    
    init(id: String, side: Double, color: RGBColor, alpha: SYAlpha) {
        self.id = id
        self.size = SYSize(width: side, height: side)
        self.color = color
        self.alpha = alpha
    }
    
    var description: String {
        "SquareSlide (\(id)), Side: \(size.width), \(color), Alpha: \(alpha)"
    }
    
    func changeColor(to color: RGBColor) {
        self.color = color
    }
    
    func changeAlpha(to alpha: SYAlpha) {
        self.alpha = alpha
    }
}
