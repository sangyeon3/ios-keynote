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
    func slideContentViewDidTapped(slideID: String)
    func slideViewDidTapped()
    func slideAddButtonDidTapped()
    func slideCellDidSelected(at index: Int)
}

protocol KeynoteViewDataSource: AnyObject {
    func numberOfSlides() -> Int
    func slideTypeImage(at index: Int) -> UIImage?
}

final class KeynoteView: UIView {
    
    enum Constants {
        static let sideBarWidth = 180.0
        static let backgroundViewRatio = 0.75
    }
    
    private let slideListSideBarView = SlideListSideBarView()
    
    private var slideViewsByID = [String: SlideView]()
    
    private let propertySideBarView = PropertySideBarView()
    
    weak var delegate: KeynoteViewDelegate?
    weak var dataSource: KeynoteViewDataSource?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupSubviewDelegateAndDataSource()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupSubviewDelegateAndDataSource()
    }
    
    func addSlideView(_ slide: Slide) {
        let newSlideView = SlideView(frame: .zero, slide: slide)
        newSlideView.delegate = self
        slideViewsByID[slide.id] = newSlideView
        
        addSubview(newSlideView)
        NSLayoutConstraint.activate([
            newSlideView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            newSlideView.leftAnchor.constraint(equalTo: slideListSideBarView.rightAnchor),
            newSlideView.rightAnchor.constraint(equalTo: propertySideBarView.leftAnchor),
            newSlideView.heightAnchor.constraint(equalTo: newSlideView.widthAnchor, multiplier: Constants.backgroundViewRatio)
        ])
        
        slideListSideBarView.addSlide()
    }
    
    func showSlideView(havingID slideID: String) {
        guard let slideView = slideViewsByID[slideID] else { return }
        self.bringSubviewToFront(slideView)
    }
    
    func addBorderToSlide(havingID id: String) {
        guard let slideView = slideViewsByID[id] else { return }
        slideView.addBorder()
    }
    
    func removeBorderToSlide(havingID id: String) {
        guard let slideView = slideViewsByID[id] else { return }
        slideView.removeBorder()
    }
    
    func updateColorOf(havingID id: String, to color: UIColor) {
        guard let slideView = slideViewsByID[id] else { return }
        slideView.updateBackgroundColor(to: color)
        propertySideBarView.updateColorLabel(to: color.hexString)
    }
    
    func updateAlphaOf(havingID id: String, to alphaValue: Int) {
        guard let slideView = slideViewsByID[id] else { return }
        slideView.updateAlpha(to: alphaValue)
        propertySideBarView.updateAlpha(to: alphaValue)
    }
    
    func disableAllProperty() {
        propertySideBarView.disableAllProperty()
    }
}

extension KeynoteView: PropertySideBarViewDelegate {
    
    func backgroundColorButtonDidTapped(_ sender: UIButton) {
        delegate?.backgroundColorButtonDidTapped(sender)
    }
    
    func alphaValueDidChanged(value: Int) {
        delegate?.alphaValueDidChanged(value: value)
    }
}

extension KeynoteView: SlideViewDelegate {
    
    func slideContentViewDidTapped(_ slideView: SlideView) {
        guard let slideViewByID = slideViewsByID.first(where: { $0.value === slideView }) else { return }
        delegate?.slideContentViewDidTapped(slideID: slideViewByID.key)
    }
    
    func slideViewDidTapped() {
        delegate?.slideViewDidTapped()
    }
}

extension KeynoteView: SlideListSideBarViewDelegate, SlideListSideBarViewDataSource {
    
    func slideAddButtonDidTapped() {
        delegate?.slideAddButtonDidTapped()
    }
    
    func slideCellDidSelected(at index: Int) {
        delegate?.slideCellDidSelected(at: index)
    }
    
    func numberOfSlides() -> Int {
        dataSource?.numberOfSlides() ?? 0
    }
    
    func slideTypeImage(at index: Int) -> UIImage? {
        dataSource?.slideTypeImage(at: index)
    }
}

extension KeynoteView {
    
    private func setupViews() {
        backgroundColor = .systemGray3
        
        addSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviewDelegateAndDataSource() {
        slideListSideBarView.delegate = self
        slideListSideBarView.dataSource = self
        
        propertySideBarView.delegate = self
    }
    
    private func addSubviews() {
        addSubview(slideListSideBarView)
        addSubview(propertySideBarView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            slideListSideBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            slideListSideBarView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            slideListSideBarView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            slideListSideBarView.widthAnchor.constraint(equalToConstant: Constants.sideBarWidth)
        ])

        NSLayoutConstraint.activate([
            propertySideBarView.topAnchor.constraint(equalTo: slideListSideBarView.topAnchor),
            propertySideBarView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            propertySideBarView.bottomAnchor.constraint(equalTo: slideListSideBarView.bottomAnchor),
            propertySideBarView.widthAnchor.constraint(equalTo: slideListSideBarView.widthAnchor)
        ])
    }
}

fileprivate extension UIColor {
    var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        let hexString = "\(String(format: "%02X", Int(red*255)))\(String(format: "%02X", Int(green*255)))\(String(format: "%02X", Int(blue*255)))"
        return "#\(hexString)"
    }
}
