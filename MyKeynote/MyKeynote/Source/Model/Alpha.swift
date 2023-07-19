//
//  Alpha.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

enum Alpha: Int, CustomStringConvertible {
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
    
    var value: Int {
        return rawValue
    }
    
    var description: String {
        return "\(value)"
    }
    
    static func randomAlpha() -> Alpha {
        return Alpha(rawValue: Int.random(in: 1...10)) ?? .one
    }
}
