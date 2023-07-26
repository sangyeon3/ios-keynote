//
//  Slide.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

class Slide: CustomStringConvertible {
    
    let id: String
    var size: SYSize
    var backgroundColor: RGBColor
    var alpha: SYAlpha
    
    required init(id: String, width: Double, color: RGBColor, alpha: SYAlpha) {
        self.id = id
        self.size = SYSize(width: width, height: width * 0.75)
        self.backgroundColor = color
        self.alpha = alpha
    }
    
    var description: String {
        "\(Self.self) (\(id)), Size: \(size.width), \(backgroundColor), Alpha: \(alpha)"
    }

    func isEqual(with other: Slide) -> Bool {
        self.id == other.id
    }
    
    func changeColor(to newColor: RGBColor) {
        backgroundColor = newColor
    }
    
    func changeAlpha(to value: Int) {
        alpha.update(to: value)
    }
}
