//
//  SlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/28.
//

import UIKit

protocol SlideViewDelegate: AnyObject {
    func contentViewDidTapped(_ slideView: SlideView)
    func slideViewDidTapped()
}

class SlideView: UIView, SlideViewTappable {
    
    var contentView: BaseSlideContentView?
    weak var delegate: SlideViewDelegate?
    
    init(contentView: BaseSlideContentView, contentSize: CGSize) {
        super.init(frame: .zero)
        
        setupTapGestureRecognizer()
        setupViews(contentView: contentView, contentSize: contentSize)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupTapGestureRecognizer()
    }
    
    func addBorder() {
        contentView?.addBorder()
    }
    
    func removeBorder() {
        contentView?.removeBorder()
    }
    
    func viewDidTapped() {
        delegate?.slideViewDidTapped()
    }
}

extension SlideView: BaseSlideContentViewDelegate {
    func slideContentViewDidTapped() {
        delegate?.contentViewDidTapped(self)
    }
}

extension SlideView {
    private func setupViews(contentView: BaseSlideContentView, contentSize: CGSize) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        setupContentView(contentView: contentView, contentSize: contentSize)
    }
    
    private func setupContentView(contentView: BaseSlideContentView, contentSize: CGSize) {
        self.contentView = contentView
        contentView.delegate = self
        
        addSubview(contentView)
        contentView.setupAutoLayout(size: contentSize)
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func viewDidTapped(_ gestureRecognizer : UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        if gestureRecognizer.state == .ended {
            viewDidTapped()
        }
    }
}

