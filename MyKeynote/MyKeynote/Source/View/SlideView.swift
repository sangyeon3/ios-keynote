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
    
    init(frame: CGRect, size: CGSize) {
        super.init(frame: frame)
        
        setupViews(size: size)
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
    
    private func setupViews(size: CGSize) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        setupSlideContentView(size: size)
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupSlideContentView(size: CGSize) {
        slideContentView = SlideContentView(frame: .zero)
        slideContentView.delegate = self
        
        addSubview(slideContentView)
        NSLayoutConstraint.activate([
            slideContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slideContentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            slideContentView.widthAnchor.constraint(equalToConstant: size.width),
            slideContentView.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    @objc private func viewDidTapped(_ gestureRecognizer : UITapGestureRecognizer ) {
        guard gestureRecognizer.view != nil else { return }
            
        if gestureRecognizer.state == .ended {
            delegate?.slideViewDidTapped()
        }
    }
}
