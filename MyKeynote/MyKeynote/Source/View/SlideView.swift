//
//  SlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/24.
//

import UIKit

protocol SlideViewDelegate: AnyObject {
    func subSlideViewDidTapped(slideID: String)
    func slideViewDidTapped()
}

final class SlideView: UIView {
    
    let slideID: String
    
    private var subSlideView: SubSlideView!
    
    weak var delegate: SlideViewDelegate?
    
    private override init(frame: CGRect) {
        slideID = ""
        super.init(frame: frame)
    }
    
    init(frame: CGRect, slide: Slide) {
        slideID = slide.id
        super.init(frame: frame)
        
        setupViews(for: slide)
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        slideID = ""
        super.init(coder: coder)
        
        setupGestureRecognizer()
    }
    
    func updateView(for slide: Slide) {
        subSlideView.update(for: slide)
    }

}

extension SlideView: SubSlideViewDelegate {
    
    func subSlideViewDidTapped() {
        delegate?.subSlideViewDidTapped(slideID: slideID)
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
