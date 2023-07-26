//
//  SlideListSideBarView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/26.
//

import UIKit

protocol SlideListSideBarViewDelegate: AnyObject {
    func slideAddButtonDidTapped()
}

final class SlideListSideBarView: UIView {
    
    enum Constants {
        static let inset = 5.0
        static let addButtonHeight = 40.0
    }
    
    private let slideAddButton = UIButton()
    
    weak var delegate: SlideListSideBarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupUIProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupUIProperties()
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        
        addSubview(slideAddButton)
        
        NSLayoutConstraint.activate([
            slideAddButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.inset),
            slideAddButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.inset),
            slideAddButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.inset),
            slideAddButton.heightAnchor.constraint(equalToConstant: Constants.addButtonHeight)
        ])
    }
    
    private func setupUIProperties() {
        slideAddButton.setTitle("+", for: .normal)
        slideAddButton.titleLabel?.font = .systemFont(ofSize: 30)
        slideAddButton.setTitleColor(.systemBlue, for: .normal)
        slideAddButton.backgroundColor = .white
        slideAddButton.layer.cornerRadius = 10
        slideAddButton.translatesAutoresizingMaskIntoConstraints = false
        
        slideAddButton.addTarget(self, action: #selector(slideAddButtonDidTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func slideAddButtonDidTapped(_ sender: UIButton) {
        delegate?.slideAddButtonDidTapped()
    }
}
