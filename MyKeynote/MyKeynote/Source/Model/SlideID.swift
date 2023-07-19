//
//  SliderID.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import Foundation

struct SlideID {
    
    private static var idSet = [String: Bool]()
    
    static func randomId() -> String {
        var id = ""

        repeat {
            id = (0..<3).map{ _ in
                pickThreeRandomString()
            }.joined(separator: "-")
        } while idSet[id] != nil

        idSet[id] = true
        
        return id
    }
    
    private static func pickThreeRandomString() -> String {
        let characterSet = "abcdefghijklmnopqrstuvwxyz0123456789".map { String($0) }
        return (0..<3).map { _ in characterSet.randomElement() ?? "a" }.joined()
    }
}
