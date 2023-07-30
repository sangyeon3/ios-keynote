//
//  KeynoteViewController.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import UIKit

class KeynoteViewController: UIViewController {
    
    private let keynoteView: KeynoteView = {
        let view = KeynoteView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var slideManager: SlideManageable
    
    private var idOfSelectedSlide: String?
    
    init(slideManager: SlideManageable) {
        self.slideManager = slideManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.slideManager = SlideManager(slideFactory: SlideFactory())
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
    }
    
    private func setupViews() {
        keynoteView.frame = view.frame
        view = keynoteView
        
        keynoteView.delegate = self
        keynoteView.dataSource = self
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            forName: SlideManager.Notifications.backgroundColorOfSlideDidChanged,
            object: slideManager,
            queue: .main,
            using: { [weak self] notification in
                guard let self,
                      let idOfSelectedSlide,
                      let userInfo = notification.userInfo,
                      let color = userInfo[SlideManager.UserInfoKey.element] as? RGBColor else {
                    return
                }
                keynoteView.updateColorOf(havingID: idOfSelectedSlide, to: UIColor(rgb: color))
            }
        )
        
        NotificationCenter.default.addObserver(
            forName: SlideManager.Notifications.alphaOfSlideDidChanged,
            object: slideManager,
            queue: .main,
            using: { [weak self] notification in
                guard let self,
                      let idOfSelectedSlide,
                      let userInfo = notification.userInfo,
                      let alpha = userInfo[SlideManager.UserInfoKey.element] as? SYAlpha else {
                    return
                }
                keynoteView.updateAlphaOf(havingID: idOfSelectedSlide, to: alpha.value)
            }
        )
        
        NotificationCenter.default.addObserver(
            forName: SlideManager.Notifications.squareSlideDidAdded,
            object: slideManager,
            queue: .main,
            using: { [weak self] notification in
                guard let self,
                      let userInfo = notification.userInfo,
                      let newSlide = userInfo[SlideManager.UserInfoKey.element] as? BaseSlide & Colorful & AlphaAdaptable else {
                    return
                }
                
                let contentView = SquareSlideContentView(color: UIColor(rgb: newSlide.color))
                let slideView = SlideView(contentView: contentView, contentSize: CGSize(sySize: newSlide.size))
                keynoteView.addSlideView(slideID: newSlide.id, newSlideView: slideView)
                keynoteView.updateColorOf(havingID: newSlide.id, to: UIColor(rgb: newSlide.color))
                keynoteView.updateAlphaOf(havingID: newSlide.id, to: newSlide.alpha.value)
            }
        )
        
        NotificationCenter.default.addObserver(
            forName: SlideManager.Notifications.photoSlideDidAdded,
            object: slideManager,
            queue: .main,
            using: { [weak self] notification in
                guard let self,
                      let userInfo = notification.userInfo,
                      let newSlide = userInfo[SlideManager.UserInfoKey.element] as? BaseSlide & Photoable & AlphaAdaptable else {
                    return
                }
                
                // TODO: image에 url로부터 이미지 불러와서 전달?
                let contentView = PhotoSlideContentView()
                let slideView = SlideView(contentView: contentView, contentSize: CGSize(sySize: newSlide.size))
                keynoteView.addSlideView(slideID: newSlide.id, newSlideView: slideView)
                keynoteView.updateAlphaOf(havingID: newSlide.id, to: newSlide.alpha.value)
            }
        )
    }
}

extension KeynoteViewController: KeynoteViewDelegate {
    
    func backgroundColorButtonDidTapped(_ sender: UIButton) {
        presentColorPicker(sender)
    }
    
    func alphaValueDidChanged(value: Int) {
        guard let idOfSelectedSlide else { return }
        slideManager.changeAlphaOf(havingID: idOfSelectedSlide, to: value)
    }
    
    func slideContentViewDidTapped(slideID: String) {
        guard let selectedSlide = slideManager.slide(havingID: slideID) else {
            return
        }
        self.idOfSelectedSlide = slideID
        
        keynoteView.addBorderToSlide(havingID: slideID)
        if let selectedSlide = selectedSlide as? Colorful {
            keynoteView.updateColorOf(havingID: slideID, to: UIColor(rgb: selectedSlide.color))
        }
        if let selectedSlide = selectedSlide as? AlphaAdaptable {
            keynoteView.updateAlphaOf(havingID: slideID, to: selectedSlide.alpha.value)
        }
    }
    
    func slideViewDidTapped() {
        guard let idOfSelectedSlide else { return }
        keynoteView.removeBorderToSlide(havingID: idOfSelectedSlide)
        keynoteView.disableAllProperty()
        self.idOfSelectedSlide = nil
    }
    
    func slideAddButtonDidTapped() {
        let randomNumber = Int.random(in: 0...1)
        switch randomNumber {
        case 0:
            slideManager.addSquareSlide()
        case 1:
            slideManager.addPhotoSlide()
        default:
            return
        }
    }
    
    func slideCellDidSelected(at index: Int) {
        if let idOfSelectedSlide {
            keynoteView.removeBorderToSlide(havingID: idOfSelectedSlide)
            keynoteView.disableAllProperty()
        }
        
        guard let selectedSlide = slideManager[index] else { return }
        idOfSelectedSlide = selectedSlide.id
        keynoteView.showSlideView(havingID: selectedSlide.id)
    }
    
    private func presentColorPicker(_ sender: UIButton) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "배경색"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceItem = sender
        present(colorPicker, animated: false)
    }
}

extension KeynoteViewController: KeynoteViewDataSource {
    
    func numberOfSlides() -> Int {
        slideManager.numberOfSlide
    }
    
    func slideTypeImage(at index: Int) -> UIImage? {
        guard let slide = slideManager[index] else {
            return .remove
        }
        return UIImage.slideTypeImage(slide)
    }
}

extension KeynoteViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        guard let idOfSelectedSlide,
              let rgbColor = color.rgbColor else {
            return
        }
        slideManager.changeBackgroundColorOf(havingID: idOfSelectedSlide, to: rgbColor)
    }
}

fileprivate extension UIImage {
    static func slideTypeImage(_ slide: BaseSlide) -> UIImage {
        switch slide {
        case is SquareSlide:
            return UIImage(systemName: "rectangle.inset.filled") ?? .remove
        default:
            return UIImage(systemName: "square") ?? .remove
        }
    }
}

fileprivate extension CGSize {
    init(sySize: SYSize) {
        self.init(width: sySize.width, height: sySize.height)
    }
}
