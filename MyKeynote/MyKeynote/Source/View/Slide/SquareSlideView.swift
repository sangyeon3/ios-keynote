//
//  SquareSlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/28.
//

import UIKit

final class SquareSlideView: BaseSlideView, SlideViewBackgroundColorChangeable, SlideViewAlphaChangeable {
    
    init(size: CGSize) {
        super.init(frame: .zero)
        
        setupViews(size: size)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews(size: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews(size: .zero)
    }
    
    func changeBackgroundColor(to color: UIColor) {
        contentView?.backgroundColor = color
    }
    
    func changeAlpha(to value: Int) {
        contentView?.alpha = CGFloat(value) / 10
    }
}

extension SquareSlideView {
    
    private func setupViews(size: CGSize) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        setupContentView(size: size)
    }
    
    private func setupContentView(size: CGSize) {
        self.contentView = UIView()
        
        guard let contentView else { return }
        
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: size.width),
            contentView.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
}
