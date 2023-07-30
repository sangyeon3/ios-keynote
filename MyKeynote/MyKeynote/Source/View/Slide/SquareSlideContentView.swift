//
//  SquareSlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/28.
//

import UIKit

final class SquareSlideContentView: BaseSlideContentView, SlideViewBackgroundColorChangeable, SlideViewAlphaChangeable {
    
    init(color: UIColor) {
        super.init(frame: .zero)
        
        setupViews(color: color)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews(color: .red)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews(color: .red)
    }
    
    override func setupAutoLayout(size: CGSize) {
        guard let superview else { return }
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    func changeBackgroundColor(to color: UIColor) {
        backgroundColor = color
    }
    
    func changeAlpha(to value: Int) {
        alpha = CGFloat(value) / 10
    }
}

extension SquareSlideContentView {
    private func setupViews(color: UIColor) {
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }
}
