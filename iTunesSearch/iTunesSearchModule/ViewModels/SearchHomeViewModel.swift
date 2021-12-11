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
    private var md: ITunesDataModel?
    
    
    // MARK: - Init
    
    init(dataController: iTunesSearchDataController,
         router: iTunesSearchRouter) {
        self.dataController = dataController
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func fetchMedia() {
        dataController.fetchMedia(searchValue: "blue") { [weak self] resultModel, error in
            if error != nil {
                return
            }
            guard let model = resultModel else {
                return
            }
            self?.md = model
        }
    }
}
