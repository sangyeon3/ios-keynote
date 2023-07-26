//
//  SlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/24.
//

import UIKit

protocol SlideViewDelegate: AnyObject {
    func slideContentViewDidTapped(_ slideView: SlideView)
    func slideViewDidTapped()
}

final class SlideView: UIView {
    
    private var slideContentView: SlideContentView!
    
    weak var delegate: SlideViewDelegate?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
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

    func addBorder() {
        slideContentView.addBorder()
    }
    
    func removeBorder() {
        slideContentView.removeBorder()
    }
    
    func updateBackgroundColor(to color: UIColor) {
        slideContentView.updateBackgroundColor(to: color)
    }
    
    func updateAlpha(to alpha: Int) {
        slideContentView.updateAlpha(to: alpha)
    }
}

extension SlideView: SlideContentViewDelegate {
    
    func slideContentViewDidTapped() {
        delegate?.slideContentViewDidTapped(self)
    }
}

extension SlideView {
    
    private func setupViews(for slide: Slide) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        setupSlideContentView(for: slide)
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupSlideContentView(for slide: Slide) {
        slideContentView = SlideContentView(frame: .zero, slide: slide)
        slideContentView.delegate = self
        
        addSubview(slideContentView)
        NSLayoutConstraint.activate([
            slideContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slideContentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            slideContentView.widthAnchor.constraint(equalToConstant: slide.size.width),
            slideContentView.heightAnchor.constraint(equalToConstant: slide.size.height)
        ])
    }
    
    @objc private func viewDidTapped(_ gestureRecognizer : UITapGestureRecognizer ) {
        guard gestureRecognizer.view != nil else { return }
            
        if gestureRecognizer.state == .ended {
            delegate?.slideViewDidTapped()
        }
    }
}
