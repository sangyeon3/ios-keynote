//
//  AlphaSettingView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/24.
//

import UIKit

protocol AlphaSettingViewDelegate: AnyObject {
    func alphaValueDidChanged(value: Int)
}

final class AlphaSettingView: UIView {
    
    enum Constants {
        static let inset = 10.0
        static let labelHeight = 20.0
        static let titleLabelFontSize = 18.0
        static let alphaValueLabelWidth = 40.0
        static let alphaStepperHeight = 40.0
    }
    
    private let titleLabel = UILabel()
    
    private let valueLabel = UILabel()
    
    private let alphaStepper = UIStepper()
    
    weak var delegate: AlphaSettingViewDelegate?
    
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
    
    func update(to alphaValue: Int) {
        valueLabel.alpha = 1.0
        alphaStepper.isEnabled = true
        
        valueLabel.text = String(alphaValue)
        alphaStepper.value = Double(alphaValue)
    }
    
    func disabled() {
        valueLabel.alpha = 0.5
        alphaStepper.isEnabled = false
    }
    
}

extension AlphaSettingView {
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        setupConstraints()
    }
    
    private func setupProperties() {
        setupTitleLabel()
        setupValueLabel()
        setupAlphaStepper()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(alphaStepper)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.inset),
            valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: Constants.alphaValueLabelWidth),
            valueLabel.heightAnchor.constraint(equalToConstant: Constants.alphaStepperHeight)
        ])
        NSLayoutConstraint.activate([
            alphaStepper.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.inset),
            alphaStepper.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: Constants.inset),
            alphaStepper.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            alphaStepper.heightAnchor.constraint(equalToConstant: Constants.alphaStepperHeight)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "투명도"
        titleLabel.font = .systemFont(ofSize: Constants.titleLabelFontSize)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupValueLabel() {
        valueLabel.text = "1"
        valueLabel.font = .systemFont(ofSize: Constants.titleLabelFontSize)
        valueLabel.textAlignment = .center
        valueLabel.textColor = .black
        valueLabel.backgroundColor = .white
        valueLabel.layer.cornerRadius = 10
        valueLabel.clipsToBounds = true
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.alpha = 0.5
    }
    
    private func setupAlphaStepper() {
        alphaStepper.maximumValue = 10
        alphaStepper.minimumValue = 1
        alphaStepper.stepValue = 1
        alphaStepper.addTarget(self, action: #selector(stepperValueDidChanged(_:)), for: .valueChanged)
        alphaStepper.translatesAutoresizingMaskIntoConstraints = false
        alphaStepper.isEnabled = false
    }
    
    @objc private func stepperValueDidChanged(_ sender: UIStepper) {
        let newValue = Int(sender.value)
        valueLabel.text = "\(newValue)"
        delegate?.alphaValueDidChanged(value: newValue)
    }
}
