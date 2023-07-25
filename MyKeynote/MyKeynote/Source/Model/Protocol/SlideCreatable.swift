//
//  SlideCreatable.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

protocol SlideCreatable {
    func makeSlide<T: Slide>(type: T.Type) -> T
}
