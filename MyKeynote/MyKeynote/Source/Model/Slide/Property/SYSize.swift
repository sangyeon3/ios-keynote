//
//  Size.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/19.
//

import Foundation

struct SYSize: CustomStringConvertible {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    init(width: Double, ratio: Double) {
        self.width = width
        self.height = width * ratio
    }
    
    static func randomSize(range: Range<Int>) -> SYSize {
        SYSize(width: Double(Int.random(in: range)), height: Double(Int.random(in: range)))
    }
    
    var description: String {
        "(width: \(width), height: \(height))"
    }
}
