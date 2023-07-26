//
//  SlideManager.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/19.
//

import Foundation

class SlideManager: SlideManageable {
    
    enum Notifications {
        static let backgroundColorOfSlideDidChanged = Notification.Name("slideBackgroundColorDidChanged")
        static let alphaOfSlideDidChanged = Notification.Name("alphaOfSlideDidChanged")
        static let slideDidAdded = Notification.Name("slideDidAdded")
    }
    
    enum UserInfoKey {
        static let color = "color"
        static let alpha = "alpha"
        static let newSlide = "newSlide"
    }
    
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
    
    @discardableResult
    func addSlide<T: Slide>(type: T.Type) -> Slide {
        let newSlide = factory.makeSlide(type: type)
        slides.append(newSlide)
        
        NotificationCenter.default.post(
            name: Notifications.slideDidAdded,
            object: self,
            userInfo: [UserInfoKey.newSlide: newSlide]
        )
        
        return newSlide
    }
    
    func changeBackgroundColorOf(havingID slideID: String, to color: RGBColor) {
        guard let slide = slide(havingID: slideID) else {
            return
        }
        slide.changeColor(to: color)
        
        NotificationCenter.default.post(
            name: Notifications.backgroundColorOfSlideDidChanged,
            object: self,
            userInfo: [UserInfoKey.color: color]
        )
    }
    
    func changeAlphaOf(havingID slideID: String, to alphaValue: Int) {
        guard let slide = slide(havingID: slideID) else {
            return
        }
        slide.changeAlpha(to: alphaValue)
        
        NotificationCenter.default.post(
            name: Notifications.alphaOfSlideDidChanged,
            object: self,
            userInfo: [UserInfoKey.alpha: alphaValue]
        )
    }
}
