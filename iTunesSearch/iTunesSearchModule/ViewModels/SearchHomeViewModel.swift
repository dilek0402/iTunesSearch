//
//  SearchHomeViewModel.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 10.12.2021.
//

final class SearchHomeViewModel {
    
    // MARK: - Private Properties
    
    private var dataController:iTunesSearchDataController
    private var router: iTunesSearchRouter

    
    // MARK: - Init
    
    init(dataController: iTunesSearchDataController,
         router: iTunesSearchRouter) {
        self.dataController = dataController
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func fetchMedia() {
        dataController.fetchMedia()
    }
    
}
