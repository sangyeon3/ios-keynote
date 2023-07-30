//
//  PhotoSlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/28.
//

import UIKit

final class PhotoSlideContentView: BaseSlideContentView, SlideViewImageChangeable, SlideViewAlphaChangeable {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .photoSlideIcon
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    enum Constants {
        static let inset = 10.0
    }

    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    override func setupAutoLayout(size: CGSize) {
        guard let superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: Constants.inset),
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    func changeSlideImage(to image: UIImage) {
        imageView.image = image
    }
    
    func changeAlpha(to value: Int) {
        imageView.alpha = CGFloat(value) / 10
    }
    
    private func setupViews() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

fileprivate extension UIImage {
    static let photoSlideIcon = UIImage(systemName: "photo")
}
