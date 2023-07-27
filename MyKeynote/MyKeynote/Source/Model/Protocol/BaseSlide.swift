//
//  BaseSlide.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/27.
//

import Foundation

protocol SlideIdentifiable {
    var id: String { get }
}

extension SlideIdentifiable {
    func isEqual(with other: SlideIdentifiable) -> Bool {
        self.id == other.id
    }
}

protocol BaseSlide: SlideIdentifiable, CustomStringConvertible {}
