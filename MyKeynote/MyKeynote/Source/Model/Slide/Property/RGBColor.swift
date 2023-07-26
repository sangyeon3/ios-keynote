//
//  RGB.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

struct RGBColor: CustomStringConvertible {
    
    static private let range = 0...255
    
    var red: Int
    var green: Int
    var blue: Int
    var alpha: SYAlpha
    
    init?(red: Int, green: Int, blue: Int, alpha: SYAlpha) {
        if !(RGBColor.range ~= red && RGBColor.range ~= green && RGBColor.range ~= blue) {
            return nil
        }
        
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    private init() {
        self.red = 0
        self.green = 0
        self.blue = 0
        self.alpha = .maxAlpha
    }
    
    static var black: RGBColor {
        RGBColor()
    }
    
    var description: String {
        "R:\(red), G:\(green), B:\(blue)"
    }
    
    static func randomRGB() -> RGBColor {
        func randomRGBValue() -> Int {
            Int.random(in: 0...255)
        }
        
        return RGBColor(
            red: randomRGBValue(),
            green: randomRGBValue(),
            blue: randomRGBValue(),
            alpha: .maxAlpha
        ) ?? .black
    }
}
