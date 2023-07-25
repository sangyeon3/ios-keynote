//
//  Slide.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

protocol SlideDelegate: AnyObject {
    func backgroundColorDidChanged(_ slide: Slide)
    func alphaDidChanged(_ slide: Slide)
}

class Slide: CustomStringConvertible {
    let id: String
    var size: SYSize
    var color: RGBColor
    
    var isSelected: Bool
    
    var alpha: SYAlpha {
        color.alpha
    }
    
    weak var delegate: SlideDelegate?
    
    required init(id: String, width: Double, color: RGBColor) {
        self.id = id
        self.size = SYSize(width: width, height: width * 0.75)
        self.color = color
        self.isSelected = false
    }
    
    var description: String {
        "\(Self.self) (\(id)), Size: \(size.width), \(color)"
    }

    func isEqual(with other: Slide) -> Bool {
        self.id == other.id
    }
    
    func changeColor(to newColor: RGBColor) {
        color = newColor
        delegate?.backgroundColorDidChanged(self)
    }
    
    func changeAlpha(to value: Int) {
        guard let alpha = SYAlpha(rawValue: value) else {
            return
        }
        color.alpha = alpha
        delegate?.alphaDidChanged(self)
    }
}
