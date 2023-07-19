//
//  Point.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

struct Point {
    var x: Double
    var y: Double
    
    static func randomPoint(maxX: Double, maxY: Double) -> Point {
        Point(
            x: Double.random(in: 0..<maxX),
            y: Double.random(in: 0..<maxY)
        )
    }
}
