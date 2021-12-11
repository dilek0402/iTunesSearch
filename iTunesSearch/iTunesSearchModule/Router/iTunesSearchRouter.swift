//
//  iTunesSearchRouter.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 10.12.2021.
//

import UIKit

final class iTunesSearchRouter {
    
    var initialViewController: UIViewController!
    
    // MARK: - Init
    
    init() {
        let controller = SearchHomeViewController()
        let dataController = iTunesSearchDataController()
        let viewModel = SearchHomeViewModel(dataController: dataController, router: self)
        controller.viewModel = viewModel
        initialViewController = controller
    }
    
}

extension iTunesSearchRouter {
    
    func proceedToSearchDetailViewController() {
        let controller = SearchDetailViewController()
        let viewModel = SearchDetailViewModel()
        initialViewController = controller
        
    }
}
