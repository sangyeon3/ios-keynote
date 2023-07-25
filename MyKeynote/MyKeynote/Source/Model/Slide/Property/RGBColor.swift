//
//  RGB.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

struct RGBColor: CustomStringConvertible {
    @RGBValue var red: Int
    @RGBValue var green: Int
    @RGBValue var blue: Int
    var alpha: SYAlpha
    
    init(red: Int, green: Int, blue: Int, alpha: SYAlpha) {
        self.alpha = alpha
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    var description: String {
        "R:\(red), G:\(green), B:\(blue), Alpha: \(alpha)"
    }
    
    var hexString: String {
        return "#\(String(format: "%02X", red))\(String(format: "%02X", green))\(String(format: "%02X", blue))"
    }
    
    static func randomRGB() -> RGBColor {
        func randomRGBValue() -> Int {
            Int.random(in: 0...255)
        }
        
        return RGBColor(
            red: randomRGBValue(),
            green: randomRGBValue(),
            blue: randomRGBValue(),
            alpha: SYAlpha.randomAlpha()
        )
    }
}
