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

protocol SlideListSideBarViewDataSource: AnyObject {
    func numberOfSlides() -> Int
    func slideTypeImage(at index: Int) -> UIImage?
}

final class SlideListSideBarView: UIView {
    
    enum Constants {
        static let inset = 5.0
        static let addButtonHeight = 40.0
    }
    
    private let slideTableView = UITableView()
    
    private let slideAddButton = UIButton()
    
    weak var delegate: SlideListSideBarViewDelegate?
    weak var dataSource: SlideListSideBarViewDataSource?
    
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
    
    func addSlide() {
        let row = (dataSource?.numberOfSlides() ?? 1) - 1
        let indexPath = IndexPath(row: row, section: 0)
        slideTableView.insertRows(at: [indexPath], with: .automatic)
        slideTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
    }
}

extension SlideListSideBarView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfSlides() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SlideListTableViewCell.identifier,
            for: indexPath
        ) as? SlideListTableViewCell else {
            return SlideListTableViewCell()
        }
    
        let image = dataSource?.slideTypeImage(at: indexPath.row) ?? .remove
        cell.bind(slideNumber: indexPath.row + 1, slideTypeImage: image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension SlideListSideBarView {
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        
        addSubviews()
        setupConstraints()
    }
    
    private func setupUIProperties() {
        setupSlideAddButton()
        setupSlideTableView()
    }
    
    private func addSubviews() {
        addSubview(slideTableView)
        addSubview(slideAddButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            slideAddButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.inset),
            slideAddButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.inset),
            slideAddButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.inset),
            slideAddButton.heightAnchor.constraint(equalToConstant: Constants.addButtonHeight)
        ])
        NSLayoutConstraint.activate([
            slideTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.inset),
            slideTableView.leadingAnchor.constraint(equalTo: slideAddButton.leadingAnchor),
            slideTableView.trailingAnchor.constraint(equalTo: slideAddButton.trailingAnchor),
            slideTableView.bottomAnchor.constraint(equalTo: slideAddButton.topAnchor, constant: -Constants.inset)
        ])
    }
    
    private func setupSlideAddButton() {
        slideAddButton.setTitle("+", for: .normal)
        slideAddButton.titleLabel?.font = .systemFont(ofSize: 30)
        slideAddButton.setTitleColor(.systemBlue, for: .normal)
        slideAddButton.backgroundColor = .white
        slideAddButton.layer.cornerRadius = 10
        slideAddButton.translatesAutoresizingMaskIntoConstraints = false
        
        slideAddButton.addTarget(self, action: #selector(slideAddButtonDidTapped(_:)), for: .touchUpInside)
    }
    
    private func setupSlideTableView() {
        slideTableView.translatesAutoresizingMaskIntoConstraints = false
        slideTableView.dataSource = self
        slideTableView.delegate = self
        slideTableView.register(SlideListTableViewCell.self, forCellReuseIdentifier: SlideListTableViewCell.identifier)
        slideTableView.backgroundColor = slideTableView.backgroundColor?.withAlphaComponent(0)
    }
    
    @objc private func slideAddButtonDidTapped(_ sender: UIButton) {
        delegate?.slideAddButtonDidTapped()
    }
}
