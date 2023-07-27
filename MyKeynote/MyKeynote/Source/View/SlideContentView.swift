//
//  SlideContentView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/19.
//

import UIKit

protocol SlideContentViewDelegate: AnyObject {
    func slideContentViewDidTapped()
}

final class SlideContentView: UIView {
    
    weak var delegate: SlideContentViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupGestureRecognizer()
    }
            
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupGestureRecognizer()
    }
    
    func addBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    func removeBorder() {
        layer.borderWidth = 0
    }
    
    func updateBackgroundColor(to color: UIColor) {
        backgroundColor = color
    }
    
    func updateAlpha(to alphaValue: Int) {
        alpha = CGFloat(alphaValue) / 10
    }
    
}

extension SlideContentView {
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func viewDidTapped(_ gestureRecognizer : UITapGestureRecognizer ) {
        guard gestureRecognizer.view != nil else { return }
            
        if gestureRecognizer.state == .ended {
            delegate?.slideContentViewDidTapped()
        }
    }
}
