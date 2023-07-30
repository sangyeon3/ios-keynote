//
//  SlideManageable.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/24.
//

import Foundation

protocol SlideAddable {
    func addSquareSlide()
    func addPhotoSlide()
}

protocol SlideChangeable {
    func changeBackgroundColorOf(havingID slideID: String, to color: RGBColor)
    func changeAlphaOf(havingID slideID: String, to alphaValue: Int)
}

protocol SlideManageable: SlideAddable, SlideChangeable {
    var numberOfSlide: Int { get }
    subscript(index: Int) -> BaseSlide? { get }
    func slide(havingID id: String) -> BaseSlide?
}
