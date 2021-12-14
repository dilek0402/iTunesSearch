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
        static let headerIdentifier : String = "headerCell"
        static let searchBarSize: CGFloat = 50
        static let title = "iTunes Search"
        static let delayTime = 1500
        static let margin: CGFloat = 10
        static let emptyText = "Arama sonuçlarınızı buradan görebilirsiniz"
    }
    
    // MARK: - Properties
    
    var viewModel: SearchHomeViewModel!
    
    // MARK: - Layout Properties
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(iTunesInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constant.reuseModuleItemIdentifier)
        collectionView.register(iTunesInfoCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Constant.headerIdentifier)
        return collectionView
    }()
    
    private var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = Constant.emptyText
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = Theme.Palette.redColor
        label.numberOfLines = 0
        return label
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
        collectionView.backgroundView = emptyLabel
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
        emptyLabel.isHidden = true
        viewModel.removeItunesImages()
        viewModel.setupItunesImages()
        viewModel.fetchMedia(searchValue: searchValue)
    }
    
    private func setupDefault() {
        emptyLabel.isHidden = false
        viewModel.removeItunesImages()
    }
}

extension SearchHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reuseModuleItemIdentifier,
                                                         for: indexPath) as? iTunesInfoCollectionViewCell {
            cell.configureCell(item: viewModel.getItemForSection(sectionIndex: indexPath.section, itemIndex: indexPath.row))
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getSectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.getItemCountForSection(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(sectionIndex: indexPath.section,
                             itemIndex: indexPath.row)
        
    }
}

extension SearchHomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width-40
        return CGSize(width: screenWidth-80, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: sizeForItem(), height: sizeForItem())
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: Constant.headerIdentifier,
                for: indexPath) as? iTunesInfoCollectionHeaderView {
                headerView.configure(title: viewModel.getSection(index: indexPath.section))
                return headerView
                
            }
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
        
    }
    
    private func sizeForItem() -> CGFloat {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 10
        let sideSpacing:CGFloat = 20
        return (screenWidth-(2 * sideSpacing) - ((numberOfItemsPerRow - 1) * spacingBetweenCells))/numberOfItemsPerRow
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
        guard let text = searchBar.text, !text.isEmpty, text.count > 3 else {
            setupDefault()
            return
        }
        let debouncedFunc = searchBar.debounce(interval: Constant.delayTime,
                                               queue: .main) {
            self.viewModel.cancelable()
            self.search(searchValue: text)
        }
        debouncedFunc()
    }
}

