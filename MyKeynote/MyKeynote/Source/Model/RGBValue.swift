//
//  RGBValue.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

@propertyWrapper
struct RGBValue: CustomStringConvertible {
    private var value = 0
    
    var wrappedValue: Int {
        get {
            return value
        }
        set {
            if 0...255 ~= newValue {
                value = newValue
            }
        }
    }
    
    var description: String {
        "\(value)"
    }
}
