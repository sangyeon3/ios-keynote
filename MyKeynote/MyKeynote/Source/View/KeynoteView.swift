//
//  KeynoteView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/18.
//

import UIKit

protocol KeynoteViewDelegate: AnyObject {
    func backgroundColorButtonDidTapped(_ sender: UIButton)
    func alphaValueDidChanged(value: Int)
    func subSlideViewDidTapped(slideID: String)
    func slideViewDidTapped()
}

final class KeynoteView: UIView {
    
    enum Constants {
        static let sideBarWidth = 180.0
        static let backgroundViewRatio = 0.75
    }
    
    private let leftSideBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var slideViews = [SlideView]()
    
    private let propertySideBarView = PropertySideBarView()
    
    weak var delegate: KeynoteViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupSubviewDelegate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupSubviewDelegate()
    }
    
    func addSlideView(_ slide: Slide) {
        let newSlideView = SlideView(frame: .zero, slide: slide)
        newSlideView.delegate = self
        slideViews.append(newSlideView)
        
        addSubview(newSlideView)
        NSLayoutConstraint.activate([
            newSlideView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            newSlideView.leftAnchor.constraint(equalTo: leftSideBarView.rightAnchor),
            newSlideView.rightAnchor.constraint(equalTo: propertySideBarView.leftAnchor),
            newSlideView.heightAnchor.constraint(equalTo: newSlideView.widthAnchor, multiplier: Constants.backgroundViewRatio)
        ])
    }
    
    func updateView(for slide: Slide) {
        guard let currentSlideView = slideViews.first(where: { $0.slideID == slide.id }) else {
            return
        }
        currentSlideView.updateView(for: slide)
        propertySideBarView.updateView(for: slide)
    }
}

extension KeynoteView: PropertySideBarViewDelegate {
    
    func backgroundColorButtonDidTapped(_ sender: UIButton) {
        delegate.backgroundColorButtonDidTapped(sender)
    }
    
    func alphaValueDidChanged(value: Int) {
        delegate.alphaValueDidChanged(value: value)
    }
}

extension KeynoteView: SlideViewDelegate {
    
    func subSlideViewDidTapped(slideID: String) {
        delegate.subSlideViewDidTapped(slideID: slideID)
    }
    
    func slideViewDidTapped() {
        delegate.slideViewDidTapped()
    }
}

extension KeynoteView {
    
    private func setupViews() {
        backgroundColor = .systemGray3
        
        addSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviewDelegate() {
        propertySideBarView.delegate = self
    }
    
    private func addSubviews() {
        addSubview(leftSideBarView)
        addSubview(propertySideBarView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            leftSideBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            leftSideBarView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            leftSideBarView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            leftSideBarView.widthAnchor.constraint(equalToConstant: Constants.sideBarWidth)
        ])

        NSLayoutConstraint.activate([
            propertySideBarView.topAnchor.constraint(equalTo: leftSideBarView.topAnchor),
            propertySideBarView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            propertySideBarView.bottomAnchor.constraint(equalTo: leftSideBarView.bottomAnchor),
            propertySideBarView.widthAnchor.constraint(equalTo: leftSideBarView.widthAnchor)
        ])
    }
}
