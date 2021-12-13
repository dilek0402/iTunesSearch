//
//  iTunesInfoCollectionHeaderView.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 13.12.2021.
//

import UIKit

final class iTunesInfoCollectionHeaderView: UICollectionReusableView {
    
    // MARK: - Constant
    
    private enum Constant {
        static let margin: CGFloat = 15
    }
    
    // MARK: - Private Properties
    
    private var title : String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: - Layout Properties
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = Theme.Palette.labelColor
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        self.title = ""
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        addConstraints([titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.margin),
                        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.margin),
                        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.margin),
                        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.margin)])
    }
    
    // MARK: - Public Methods
    
    func configure( title : String) {
        self.title = title
    }
}
