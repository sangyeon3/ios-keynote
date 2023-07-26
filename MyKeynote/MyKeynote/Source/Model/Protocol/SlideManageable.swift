//
//  SlideManageable.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/24.
//

import Foundation

protocol SlideManageable {
    var numberOfSlide: Int { get }
    
    func slide(havingID id: String) -> Slide?
    @discardableResult
    func addSlide<T: Slide>(type: T.Type) -> Slide
    func changeBackgroundColorOf(havingID slideID: String, to color: RGBColor)
    func changeAlphaOf(havingID slideID: String, to alphaValue: Int)
}
