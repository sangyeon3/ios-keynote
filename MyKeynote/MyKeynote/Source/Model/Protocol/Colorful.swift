//
//  SlideColorful.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/27.
//

import Foundation

protocol Colorful {
    var color: RGBColor { get }
    func changeColor(to color: RGBColor)
}
