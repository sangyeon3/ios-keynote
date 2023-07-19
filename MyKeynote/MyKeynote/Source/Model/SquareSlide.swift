//
//  SquareSlide.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

final class SquareSlide: Slide {
    
    static var nextIndex: Int = 1
    
    private(set) var id: String
    private(set) var index: Int
    var point: Point
    var backgroundColor: RGB
    var alpha: Alpha
    var side: Int   // 한 변의 길이
    
    init(id: String, index: Int, point: Point, backgroundColor: RGB, alpha: Alpha, side: Int) {
        self.id = id
        self.index = index
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
        self.side = side
    }
    
    var description: String {
        "\(Self.self)\(index) (\(id)), Side:\(side), \(backgroundColor), Alpha:\(alpha)"
    }
}
