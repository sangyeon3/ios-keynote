//
//  UIColor+.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/19.
//

import UIKit

extension UIColor {
    convenience init(rgb: RGBColor) {
        self.init(
            red: CGFloat(rgb.red) / 255,
            green: CGFloat(rgb.green) / 255,
            blue: CGFloat(rgb.blue) / 255,
            alpha: CGFloat(rgb.alpha.value) / 10
        )
    }
    
    var rgbColor: RGBColor? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let syAlpha = SYAlpha(value: Int(alpha * 10)) ?? .minAlpha
        return RGBColor(red: Int(red*255), green: Int(green*255), blue: Int(blue*255), alpha: syAlpha)
    }
}
