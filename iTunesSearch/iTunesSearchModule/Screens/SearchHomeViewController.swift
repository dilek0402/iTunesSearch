//
//  SearchHomeViewController.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 10.12.2021.
//

import UIKit

final class SearchHomeViewController: UIViewController {
    
    // MARK: - Constant
    
    private enum Constant {
        static let reuseModuleItemIdentifier : String = "moduleCell"
        static let searchBarSize: CGFloat = 50
        static let title = "iTunes Search"
        static let delayTime = 800
        static let margin: CGFloat = 10
    }
    
    // MARK: - Properties
    
    var viewModel: SearchHomeViewModel!
    
    // MARK: - Layout Properties
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0.0;
        layout.minimumLineSpacing = 0.0;
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 15
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(iTunesInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constant.reuseModuleItemIdentifier)
        return collectionView
    }()
    
    
    
    // MARK: - Init  Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        setupUI()
        setupConstraints()
        setupCollectionView()
        viewModel.delegate = self
        
    }
    
    // MARK: - Private  Methods
    
    private func setupUI() {
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    private func applyStyling() {
        self.view.backgroundColor = Theme.Palette.backgroundColor
        self.title = Constant.title
    }
    
    private func setupConstraints() {
        self.view.addConstraints([searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                                  searchBar.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor),
                                  searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                                  searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                  searchBar.heightAnchor.constraint(equalToConstant: Constant.searchBarSize)])
        
        self.view.addConstraints([collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
                                  collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                  collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                  collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        
        
    }
    
    private func search(searchValue: String) {
        viewModel.fetchMedia(searchValue: searchValue)
    }
}

extension SearchHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reuseModuleItemIdentifier,
                                                         for: indexPath) as? iTunesInfoCollectionViewCell {
            cell.configureCell(item: viewModel.images[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
}

extension SearchHomeViewController: SearchHomeViewModelDelegate {
    func imageLoaded() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchHomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        guard  !searchText.isEmpty else {
            return
        }
        if searchText.count > 2 {
            let debouncedFunc = searchBar.debounce(interval: Constant.delayTime,
                                                   queue: .main) {
                self.search(searchValue: searchText)
            }
            debouncedFunc()
        }
    }
}

