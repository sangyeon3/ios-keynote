//
//  SubSlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/19.
//

import UIKit

protocol SubSlideViewDelegate: AnyObject {
    func subSlideViewDidTapped()
}

final class SubSlideView: UIView {
    
    weak var delegate: SubSlideViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizer()
    }
    
    init(frame: CGRect, slide: Slide) {
        super.init(frame: frame)
        setupViews(for: slide)
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGestureRecognizer()
    }
    
    func update(for slide: Slide) {
        setupViews(for: slide)
        setupBorder(slide.isSelected)
    }
    
    private func setupViews(for slide: Slide) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(rgb: slide.color)
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func viewDidTapped(_ gestureRecognizer : UITapGestureRecognizer ) {
        guard gestureRecognizer.view != nil else { return }
            
        if gestureRecognizer.state == .ended {
            delegate?.subSlideViewDidTapped()
        }
    }
    
    private func setupBorder(_ state: Bool) {
        if state {
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        } else {
            layer.borderWidth = 0
        }
    }
}
