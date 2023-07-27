//
//  SlideAlphaChangeable.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/27.
//

import Foundation

protocol AlphaAdaptable {
    var alpha: SYAlpha { get }
    func changeAlpha(to alpha: SYAlpha)
}
