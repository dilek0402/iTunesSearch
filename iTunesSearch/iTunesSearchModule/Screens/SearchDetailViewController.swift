//
//  SearchDetailViewController.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 10.12.2021.
//

import Foundation
import UIKit

class SearchDetailViewController: UIViewController {
    
    // MARK: - Constant
    
    private enum Constant {
        static let title = "iTunes Search Detail"
    }
    
    // MARK: - Properties
    
    var viewModel: SearchDetailViewModel!
    
    // MARK: - Layout Properties
    
    private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init  Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        setupUI()
        setupConstraints()
        updateView()
    }
    
    // MARK: - Private  Methods
    
    
    private func applyStyling() {
        self.view.backgroundColor = Theme.Palette.backgroundColor
        self.title = Constant.title
    }
    
    private func setupUI() {
        self.view.addSubview(posterImageView)
    }
    
    private func setupConstraints() {
        let size = viewModel.getImageSize()
        self.view.addConstraints([posterImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                  posterImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
                                  posterImageView.widthAnchor.constraint(equalToConstant: size.width),
                                  posterImageView.heightAnchor.constraint(equalToConstant: size.height)])
    }
    
    private func updateView() {
        posterImageView.image = viewModel.getImage()
    }
    
}
