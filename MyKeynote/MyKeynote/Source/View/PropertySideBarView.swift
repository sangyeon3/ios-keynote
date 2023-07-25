//
//  PropertySideBarView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/20.
//

import UIKit

protocol PropertySideBarViewDelegate: AnyObject {
    func backgroundColorButtonDidTapped(_ sender: UIButton)
    func alphaValueDidChanged(value: Int)
}

final class PropertySideBarView: UIView {
    
    enum Constants {
        static let inset = 10.0
        static let colorSettingViewHeight = ColorSettingView.Constants.labelHeight + ColorSettingView.Constants.backgroundColorButtonHeight + inset
        static let alphaSettingViewHeight = AlphaSettingView.Constants.labelHeight + AlphaSettingView.Constants.alphaStepperHeight + inset
    }
    
    private let backgroundColorSettingView = ColorSettingView()
    
    private let alphaSettingView = AlphaSettingView()
    
    weak var delegate: PropertySideBarViewDelegate?
    
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
    
    func updateView(for slide: Slide) {
        backgroundColorSettingView.updateView(for: slide)
        alphaSettingView.updateView(for: slide)
    }
}

extension PropertySideBarView: ColorSettingViewDelegate {
    
    func colorButtonDidTapped(_ sender: UIButton) {
        delegate?.backgroundColorButtonDidTapped(sender)
    }
}

extension PropertySideBarView: AlphaSettingViewDelegate {
    
    func alphaValueDidChanged(value: Int) {
        delegate?.alphaValueDidChanged(value: value)
    }
}

extension PropertySideBarView {
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        
        addSubviews()
        setupConstraints()
    }
    
    private func setupSubviewDelegate() {
        backgroundColorSettingView.delegate = self
        alphaSettingView.delegate = self
    }
    
    private func addSubviews() {
        addSubview(backgroundColorSettingView)
        addSubview(alphaSettingView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundColorSettingView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.inset),
            backgroundColorSettingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.inset),
            backgroundColorSettingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.inset),
            backgroundColorSettingView.heightAnchor.constraint(equalToConstant: Constants.colorSettingViewHeight)
        ])
        NSLayoutConstraint.activate([
            alphaSettingView.topAnchor.constraint(equalTo: backgroundColorSettingView.bottomAnchor, constant: Constants.inset),
            alphaSettingView.leadingAnchor.constraint(equalTo: backgroundColorSettingView.leadingAnchor),
            alphaSettingView.trailingAnchor.constraint(equalTo: backgroundColorSettingView.trailingAnchor),
            alphaSettingView.heightAnchor.constraint(equalToConstant: Constants.alphaSettingViewHeight)
        ])
    }

}
