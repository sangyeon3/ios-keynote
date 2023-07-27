//
//  SlideListTableViewCell.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/26.
//

import UIKit

final class SlideListTableViewCell: UITableViewCell {
    
    static let identifier = "SlideListTableViewCell"
    
    enum Constants {
        static let inset = 5.0
        static let slideNumberLabelHeight = 30.0
        static let slideNumberLabelWidth = 50.0
    }
    
    private let slideNumberLabel = UILabel()
    
    private let slideTypeImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupUIProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupUIProperties()
    }
    
    func configure(slideNumber: Int, slideTypeImage: UIImage) {
        slideNumberLabel.text = String(slideNumber)
        slideTypeImageView.image = slideTypeImage
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        
        addSubviews()
        setupConstraints()
    }
    
    private func setupUIProperties() {
        setupSlideNumberLabel()
        setupSlideTypeImageView()
    }
    
}

extension SlideListTableViewCell {
    
    private func addSubviews() {
        addSubview(slideNumberLabel)
        addSubview(slideTypeImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            slideNumberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.inset),
            slideNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            slideNumberLabel.widthAnchor.constraint(equalToConstant: Constants.slideNumberLabelWidth),
            slideNumberLabel.heightAnchor.constraint(equalToConstant: Constants.slideNumberLabelHeight)
        ])
        NSLayoutConstraint.activate([
            slideTypeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.inset),
            slideTypeImageView.leadingAnchor.constraint(equalTo: slideNumberLabel.trailingAnchor, constant: Constants.inset),
            slideTypeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.inset),
            slideTypeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.inset)
        ])
    }
    
    private func setupSlideNumberLabel() {
        slideNumberLabel.text = "0"
        slideNumberLabel.textAlignment = .right
        slideNumberLabel.textColor = .black
        slideNumberLabel.font = .systemFont(ofSize: 24)
        slideNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSlideTypeImageView() {
        slideTypeImageView.image = .remove
        slideTypeImageView.tintColor = .gray
        slideTypeImageView.backgroundColor = .systemGray2
        slideTypeImageView.layer.cornerRadius = 5
        slideTypeImageView.contentMode = .scaleAspectFit
        slideTypeImageView.translatesAutoresizingMaskIntoConstraints = false
    }
}
