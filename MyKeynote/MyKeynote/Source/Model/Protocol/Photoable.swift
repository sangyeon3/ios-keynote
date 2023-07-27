//
//  SlidePhotoable.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/27.
//

import Foundation

protocol Photoable {
    var url: String { get }
    func changPhoto(to url: String)
}
