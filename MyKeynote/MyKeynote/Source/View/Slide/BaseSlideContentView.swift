//
//  BaseSlideContentView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/29.
//

import UIKit

protocol BaseSlideContentViewDelegate: AnyObject {
    func slideContentViewDidTapped()
}

class BaseSlideContentView: UIView, SlideViewTappable, SlideViewBorderable {

    weak var delegate: BaseSlideContentViewDelegate?
    
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
    
    func setupAutoLayout(size: CGSize) {
        guard let superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    func addBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    func removeBorder() {
        layer.borderWidth = 0
    }
    
    func viewDidTapped() {
        delegate?.slideContentViewDidTapped()
    }
}

extension BaseSlideContentView {
    
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
            viewDidTapped()
        }
    }
}

