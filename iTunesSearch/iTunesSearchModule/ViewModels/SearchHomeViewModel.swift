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
    
    // MARK: - Private Properties
    
    private var dataController:iTunesSearchDataController
    private var router: iTunesSearchRouter
    private var screenShots: [String]?
    
    private var iTunesImageList: [iTunesImages]? = []
    
    
    // MARK: - Init
    
    init(dataController: iTunesSearchDataController,
         router: iTunesSearchRouter) {
        self.dataController = dataController
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func getSectionCount() -> Int {
        iTunesImageList?.count ?? 0
    }
    
    func getItemCountForSection(index: Int) -> Int {
        iTunesImageList?[index].screenshots?.count ?? 0
    }
    
    func getItemForSection(sectionIndex: Int, itemIndex: Int) -> UIImage {
        iTunesImageList?[sectionIndex].screenshots?[itemIndex] ?? UIImage()
    }
    
    func getSection(index: Int) -> String {
        iTunesImageList?[index].sectionName ?? ""
    }
    
    func selectItem(sectionIndex: Int, itemIndex: Int) {
        let image = iTunesImageList?[sectionIndex].screenshots?[itemIndex] ?? UIImage()
        proceedToSearchDetailViewController(image: image)
    }
    
    func fetchMedia(searchValue: String) {
        dataController.fetchMedia(searchValue: searchValue) { [weak self] resultModel, error in
            if error != nil {
                return
            }
            guard let model = resultModel else {
                return
            }
            self?.getImages(results: model.results)
        }
    }
    
    func removeItunesImages() {
        iTunesImageList = []
        delegate?.imageLoaded()
    }
    
    func setupItunesImages() {
        ["0-100 KB","100-250 KB","250-500 KB","500+ KB"].forEach { item in
            iTunesImageList?.append(iTunesImages(screenshots: [UIImage](), sectionName: item))
        }
    }
    
    func cancelable() {
        MultiThreadHelper.multiThread.cancelable()
    }
    
    // MARK: - Private Methods
    
    private func getImages(results: [Result]) {
        screenShots = results.compactMap { $0 }.compactMap { $0.screenshotUrls }.flatMap{ $0}.map{ $0}
        
        if let screenShots = screenShots, screenShots.count > 0 {
            MultiThreadHelper.multiThread.downloadImage(imageList: screenShots) { [weak self] image, section in
                if let image = image {
                    self?.iTunesImageList?[section].screenshots?.append(image)
                    self?.delegate?.imageLoaded()
                }
            }
        }
    }
    
    private func proceedToSearchDetailViewController(image: UIImage) {
        router.proceedToSearchDetailViewController(image: image)
    }
}

// MARK: - Delegate

protocol SearchHomeViewModelDelegate: NSObject {
    func imageLoaded()
}
