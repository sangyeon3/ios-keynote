//
//  BaseSlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/27.
//

import UIKit

protocol BaseSlideViewDelegate: AnyObject {
    func slideContentViewDidTapped(_ slideView: BaseSlideView)
    func slideViewDidTapped()
}

class BaseSlideView: UIView, SlideViewBorderable, SlideViewTappable {
    var contentView: UIView?
    private weak var delegate: BaseSlideViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupTapGestureRecognizer()
    }
    
    func addBorder() {
        contentView?.layer.borderWidth = 1
        contentView?.layer.borderColor = UIColor.black.cgColor
    }
    
    func removeBorder() {
        contentView?.layer.borderWidth = 0
    }
    
    func viewDidTapped() {
        delegate?.slideViewDidTapped()
    }
    
    func contentViewDidTapped() {
        delegate?.slideContentViewDidTapped(self)
    }
}

extension BaseSlideView {
    private func setupTapGestureRecognizer() {
        let viewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        addGestureRecognizer(viewTapGestureRecognizer)
        
        let contentViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(contentViewDidTapped(_:)))
        contentView?.addGestureRecognizer(contentViewTapGestureRecognizer)
    }
    
    @objc private func viewDidTapped(_ gestureRecognizer : UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        if gestureRecognizer.state == .ended {
            viewDidTapped()
        }
    }
    
    @objc private func contentViewDidTapped(_ gestureRecognizer : UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        if gestureRecognizer.state == .ended {
            contentViewDidTapped()
        }
    }
}
