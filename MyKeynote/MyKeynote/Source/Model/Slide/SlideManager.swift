//
//  SlideManager.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/19.
//

import Foundation

struct SlideManager: SlideManageable {
    
    private var slides: [Slide] = []
    
    var numberOfSlide: Int {
        slides.count
    }
    
    private let factory: SlideCreatable
    
    init(factory: SlideCreatable) {
        self.factory = factory
    }
    
    subscript(index: Int) -> Slide? {
        if 0..<numberOfSlide ~= index {
            return slides[index]
        }
        return nil
    }
    
    func slide(havingID id: String) -> Slide? {
        slides.first(where: { $0.id == id })
    }

    mutating func addSlide<T: Slide>(type: T.Type) -> Slide {
        let newSlide = factory.makeSlide(type: type)
        slides.append(newSlide)
        return newSlide
    }
}
