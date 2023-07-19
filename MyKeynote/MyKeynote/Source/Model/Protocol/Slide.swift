//
//  Slide.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

protocol Slide: CustomStringConvertible {
    static var nextIndex: Int { get set }
    
    var id: String { get }
    var index: Int { get }
    var point: Point { get }
    var backgroundColor: RGB { get }
    var alpha: Alpha { get }
}

extension Slide {
    static func fetchNextIndex() -> Int {
        nextIndex += 1
        return nextIndex-1
    }
}
