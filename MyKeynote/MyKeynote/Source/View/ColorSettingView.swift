//
//  ColorSettingView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/24.
//

import UIKit

protocol ColorSettingViewDelegate: AnyObject {
    func colorButtonDidTapped(_ sender: UIButton)
}

final class ColorSettingView: UIView {
    
    enum Constants {
        static let inset = 10.0
        static let labelHeight = 20.0
        static let titleLabelFontSize = 18.0
        static let backgroundColorButtonFontSize = 20.0
        static let backgroundColorButtonHeight = 40.0
    }
    
    private let titleLabel = UILabel()
    
    private let colorButton = UIButton()
    
    weak var delegate: ColorSettingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        setupViews()
        setupProperties()
    }
    
    func updateColorLabel(to hexColor: String) {
        colorButton.isEnabled = true
        colorButton.alpha = 1
        colorButton.setTitle(hexColor, for: .normal)
    }
    
    func disabled() {
        colorButton.isEnabled = false
        colorButton.alpha = 0.5
    }
}

extension ColorSettingView {
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        setupConstraints()
    }
    
    private func setupProperties() {
        setupTitleLabel()
        setupColorButton()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(colorButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
        NSLayoutConstraint.activate([
            colorButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.inset),
            colorButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorButton.heightAnchor.constraint(equalToConstant: Constants.backgroundColorButtonHeight)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "배경색"
        titleLabel.font = .systemFont(ofSize: Constants.titleLabelFontSize)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupColorButton() {
        colorButton.setTitle("0x000000", for: .normal)
        colorButton.setTitleColor(.black, for: .normal)
        colorButton.titleLabel?.font = .systemFont(ofSize: Constants.backgroundColorButtonFontSize)
        colorButton.backgroundColor = .white
        colorButton.layer.cornerRadius = 10
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.addTarget(self, action: #selector(colorButtonDidTouched(_:)), for: .touchUpInside)
        
        colorButton.isEnabled = false
        colorButton.alpha = 0.5
    }
    
    @objc private func colorButtonDidTouched(_ sender: UIButton) {
        delegate?.colorButtonDidTapped(sender)
    }
}
