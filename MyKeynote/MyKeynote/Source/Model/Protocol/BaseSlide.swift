//
//  BaseSlide.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/27.
//

import Foundation

protocol BaseSlide {
    var id: String { get }
    var size: SYSize { get }
    func changeSize(to size: SYSize)
}
