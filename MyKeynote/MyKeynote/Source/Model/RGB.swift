//
//  RGB.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

struct RGB: CustomStringConvertible {
    @RGBValue var red: Int
    @RGBValue var green: Int
    @RGBValue var blue: Int
    
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    var description: String {
        "R:\(red), G:\(green), B:\(blue)"
    }
    
    static func randomRGB() -> RGB {
        func randomRGBValue() -> Int {
            Int.random(in: 0...255)
        }
        
        return RGB(
            red: randomRGBValue(),
            green: randomRGBValue(),
            blue: randomRGBValue()
        )
    }
}
