//
//  iTunesInfoCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 13.12.2021.
//

import Foundation
import UIKit

final class iTunesInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constant
    
    private  enum Constant {
        static let itemSize: CGFloat = 95
    }
    
    private var image: UIImage? {
        didSet {
            if let image = image {
                logoImageView.image = image
            }
        }
    }
    
    // MARK: - Layout Properties
    
    var imageContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: -  initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        self.addSubview(imageContainerView)
        self.imageContainerView.addSubview(logoImageView)
    }
    
    private func setupConstraints() {
        addConstraints([imageContainerView.topAnchor.constraint(equalTo: topAnchor),
                        imageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
                        imageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        imageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor)])
        addConstraints([logoImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
                        logoImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
                        logoImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
                        logoImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor)])
        
    }
    // MARK: - Public Methods
    
    func configureCell(item: UIImage) {
        image = item
    }
}
