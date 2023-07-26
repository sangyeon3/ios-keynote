//
//  SlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/24.
//

import UIKit

protocol SlideViewDelegate: AnyObject {
    func subSlideViewDidTapped(_ slideView: SlideView)
    func slideViewDidTapped()
}

final class SlideView: UIView {
    
    private var subSlideView: SubSlideView!
    
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
        subSlideView.addBorder()
    }
    
    func removeBorder() {
        subSlideView.removeBorder()
    }
    
    func updateBackgroundColor(to color: UIColor) {
        subSlideView.updateBackgroundColor(to: color)
    }
    
    func updateAlpha(to alpha: Int) {
        subSlideView.updateAlpha(to: alpha)
    }
}

extension SlideView: SubSlideViewDelegate {
    
    func subSlideViewDidTapped() {
        delegate?.subSlideViewDidTapped(self)
    }
}

extension SlideView {
    
    private func setupViews(for slide: Slide) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        setupSubSlideView(for: slide)
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupSubSlideView(for slide: Slide) {
        subSlideView = SubSlideView(frame: .zero, slide: slide)
        subSlideView.delegate = self
        
        addSubview(subSlideView)
        NSLayoutConstraint.activate([
            subSlideView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subSlideView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            subSlideView.widthAnchor.constraint(equalToConstant: slide.size.width),
            subSlideView.heightAnchor.constraint(equalToConstant: slide.size.height)
        ])
    }
    
    @objc private func viewDidTapped(_ gestureRecognizer : UITapGestureRecognizer ) {
        guard gestureRecognizer.view != nil else { return }
            
        if gestureRecognizer.state == .ended {
            delegate?.slideViewDidTapped()
        }
    }
}
