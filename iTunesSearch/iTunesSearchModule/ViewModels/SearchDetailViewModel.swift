//
//  SearchDetailViewModel.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 10.12.2021.
//

import UIKit

final class SearchDetailViewModel {
    
    // MARK: - Private properties
    
    private var router: iTunesSearchRouter
    
    var image: UIImage?
    
    // MARK: - Init
    
    init(router: iTunesSearchRouter) {
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func getImageSize() -> (width: CGFloat, height: CGFloat) {
        if let image = image {
            return (image.size.width, image.size.height)
        }
        return (0,0)
    }
    
    func getImage() -> UIImage {
        if let image = image {
            return image
        }
        return UIImage()
    }
}
