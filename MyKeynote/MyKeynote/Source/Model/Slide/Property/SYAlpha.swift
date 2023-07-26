//
//  Alpha.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

struct SYAlpha: CustomStringConvertible {

    private static let minValue = 1
    private static let maxValue = 10
    private static let range = minValue...maxValue
    
    private(set) var value: Int
    
    init?(value: Int) {
        if !(SYAlpha.range ~= value) {
            return nil
        }
        self.value = value
    }
    
    /// alpha 값이 1인 SYAlpha
    static var minAlpha: SYAlpha {
        SYAlpha(value: minValue)!
    }
    
    /// alpha 값이 10인 SYAlpha
    static var maxAlpha: SYAlpha {
        SYAlpha(value: maxValue)!
    }
    
    var description: String {
        return "\(value)"
    }
    
    /// newValue 값으로 value를 수정. 만약 범위를 벗어날 경우 가장 가까운 값으로 업데이트
    mutating func update(to newValue: Int) {
        if SYAlpha.range ~= newValue {
            value = newValue
        } else if SYAlpha.minValue > newValue {
            value = SYAlpha.minValue
        } else {
            value = SYAlpha.maxValue
        }
    }
    
    static func randomAlpha() -> SYAlpha {
        return SYAlpha(value: Int.random(in: SYAlpha.minValue...SYAlpha.maxValue)) ?? .minAlpha
    }
}
