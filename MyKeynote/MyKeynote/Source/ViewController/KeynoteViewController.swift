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
    
    init(slideManager: SlideManageable) {
        self.slideManager = slideManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.slideManager = SlideManager(factory: SlideFactory())
        super.init(coder: coder)
    }
    
    private var selectedSlide: Slide?
    
    override func loadView() {
        super.loadView()
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temp()
    }
    
    private func setupViews() {
        keynoteView.frame = view.frame
        keynoteView.delegate = self
        view = keynoteView
    }
    
    private func temp() {
        let newSlide = slideManager.addSlide(type: SquareSlide.self)
        newSlide.delegate = self
        keynoteView.addSlideView(newSlide)
    }
}

extension KeynoteViewController: KeynoteViewDelegate {
    
    func backgroundColorButtonDidTapped(_ sender: UIButton) {
        presentColorPicker(sender)
    }
    
    func alphaValueDidChanged(value: Int) {
        guard let selectedSlide else { return }
        selectedSlide.changeAlpha(to: value)
    }
    
    func subSlideViewDidTapped(slideID: String) {
        guard let selectedSlide = slideManager.slide(havingID: slideID) else {
            return
        }
        
        selectedSlide.isSelected = true
        self.selectedSlide = selectedSlide
        keynoteView.updateView(for: selectedSlide)
    }
    
    func slideViewDidTapped() {
        selectedSlide?.isSelected = false
        guard let selectedSlide else { return }
        keynoteView.updateView(for: selectedSlide)
        self.selectedSlide = nil
    }
    
    private func presentColorPicker(_ sender: UIButton) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "배경색"
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceItem = sender
        present(colorPicker, animated: false)
    }
}

extension KeynoteViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        selectedSlide?.changeColor(to: color.rgbColor)
    }
}

extension KeynoteViewController: SlideDelegate {
    func backgroundColorDidChanged(_ slide: Slide) {
        keynoteView.updateView(for: slide)
    }
    
    func alphaDidChanged(_ slide: Slide) {
        keynoteView.updateView(for: slide)
    }
}
