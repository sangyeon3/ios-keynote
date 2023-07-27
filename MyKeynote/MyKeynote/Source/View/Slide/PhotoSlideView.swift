//
//  PhotoSlideView.swift
//  MyKeynote
//
//  Created by  sangyeon on 2023/07/28.
//

import UIKit

final class PhotoSlideView: BaseSlideView, SlideViewImageChangeable, SlideViewAlphaChangeable {
    
    enum Constants {
        static let inset = 10.0
    }

    init(image: UIImage?) {
        super.init(frame: .zero)
        
        setupViews(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews(image: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews(image: nil)
    }
    
    func changeSlideImage(to image: UIImage) {
        guard let contentView = contentView as? UIImageView else { return }
        contentView.image = image
    }
    
    func changeAlpha(to value: Int) {
        contentView?.alpha = CGFloat(value) / 10
    }
    
    private func setupViews(image: UIImage?) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        setupContentView(image: image)
    }
    
    private func setupContentView(image: UIImage?) {
        let image = image ?? .photoSlideIcon
        contentView = UIImageView(image: image)
        contentView?.contentMode = .scaleAspectFit
        
        guard let contentView else { return }
        
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.inset),
//            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.inset),
//            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.inset),
            contentView.widthAnchor.constraint(equalToConstant: 100),
            contentView.heightAnchor.constraint(equalToConstant: 100),
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

fileprivate extension UIImage {
    static let photoSlideIcon = UIImage(systemName: "photo")
}
