//
//  PhotoSlide.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/27.
//

import Foundation

final class PhotoSlide: BaseSlide, Photoable, AlphaAdaptable {
    
    var id: String
    private(set) var photoURL: URL?
    private(set) var alpha: SYAlpha
    
    init(id: String, photoURL: URL? = nil, alpha: SYAlpha = .maxAlpha) {
        self.id = id
        self.photoURL = photoURL
        self.alpha = alpha
    }
    
    var description: String {
        "PhotoSlide (\(id)), PhotoURL: \(photoURL), Alpha: \(alpha)"
    }

    func changPhoto(to url: URL) {
        self.photoURL = url
    }
    
    func changeAlpha(to alpha: SYAlpha) {
        self.alpha = alpha
    }
}
