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
    mutating func addSlide<T: Slide>(type: T.Type) -> Slide
}
