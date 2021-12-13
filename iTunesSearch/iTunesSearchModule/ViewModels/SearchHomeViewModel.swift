//
//  SearchHomeViewModel.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 10.12.2021.
//

import UIKit

final class SearchHomeViewModel {
    
    // MARK: - Private Properties
    
    weak var delegate: SearchHomeViewModelDelegate?
    var images: [UIImage] = []
    
    // MARK: - Private Properties
    
    private var dataController:iTunesSearchDataController
    private var router: iTunesSearchRouter
    private var md: ITunesDataModel?
    private var screenShots: [String]?
    
    // MARK: - Init
    
    init(dataController: iTunesSearchDataController,
         router: iTunesSearchRouter) {
        self.dataController = dataController
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func fetchMedia(searchValue: String) {
        dataController.fetchMedia(searchValue: searchValue) { [weak self] resultModel, error in
            if error != nil {
                return
            }
            guard let model = resultModel else {
                return
            }
            self?.md = model
            self?.getImages(results: model.results)
        }
    }
    
    // MARK: - Private Methods
    
    private func getImages(results: [Result]) {
        screenShots = results.compactMap { $0 }.compactMap { $0.screenshotUrls }.flatMap{ $0}.map{ $0}
        let evenList = screenShots?.enumerated().filter({$0.offset % 2 == 0}).map({ $0.element})
        let oddList = screenShots?.enumerated().filter({$0.offset % 2 != 0}).map({ $0.element})
        
        if let evenList = evenList {
            MultiThreadHelper.multiThread.downloadImage(imageList: evenList) { image in
                if let image = image {
                    self.images.append(image)
                    self.delegate?.imageLoaded()
                }
            }
        }
    }
}

// MARK: - Delegate

protocol SearchHomeViewModelDelegate: NSObject {
    func imageLoaded()
}
