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
        static let element = "element"
    }
    
    private var slides: [BaseSlide] = []
    
    var numberOfSlide: Int {
        slides.count
    }
    
    private let factory: SlideCreatable
    
    init(factory: SlideCreatable) {
        self.factory = factory
    }
    
    subscript(index: Int) -> BaseSlide? {
        if 0..<numberOfSlide ~= index {
            return slides[index]
        }
        return nil
    }
    
    func slide(havingID id: String) -> BaseSlide? {
        slides.first(where: { $0.id == id })
    }
    
    @discardableResult
    func addSlide<T: Slide>(type: T.Type) -> Slide {
        let newSlide = factory.makeSlide(type: type)
        slides.append(newSlide)
        
        NotificationCenter.default.post(
            name: Notifications.slideDidAdded,
            object: self,
            userInfo: [UserInfoKey.element: newSlide]
        )
        
        return newSlide
    }
    
    func changeBackgroundColorOf(havingID slideID: String, to color: RGBColor) {
        guard let slide = slide(havingID: slideID) as? Colorful else {
            return
        }
        slide.changeColor(to: color)
        
        NotificationCenter.default.post(
            name: Notifications.backgroundColorOfSlideDidChanged,
            object: self,
            userInfo: [UserInfoKey.element: color]
        )
    }
    
    func changeAlphaOf(havingID slideID: String, to alphaValue: Int) {
        guard let slide = slide(havingID: slideID) as? AlphaAdaptable,
              let alpha = SYAlpha(value: alphaValue) else {
            return
        }
        slide.changeAlpha(to: alpha)
        
        NotificationCenter.default.post(
            name: Notifications.alphaOfSlideDidChanged,
            object: self,
            userInfo: [UserInfoKey.element: alpha]
        )
    }
}
