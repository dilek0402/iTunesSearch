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
        
    }
    
    // MARK: - Properties
    
    var viewModel: SearchHomeViewModel!
    
    // MARK: - Layout Properties
    
  /*  private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var searchCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()*/
    
    
    
    // MARK: - Init  Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchMedia()
    }
    
    // MARK: - Private  Methods
    
    private func setupUI() {
        
    }
    
    private func makeAutoLayout() {
        
    }
    
}

