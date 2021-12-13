//
//  ImageCache.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 13.12.2021.
//

import Foundation
import UIKit

public class ImageCache {
    
    // MARK: - Properties
    
    public static let publicCache = ImageCache()
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(UIImage?, Int) -> Swift.Void]]()
    
    // MARK: - Methods
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    public final func load(url: NSURL, completion: @escaping (UIImage?, Int) -> Swift.Void) {
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage,0)
            }
            return
        }
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        // Go fetch the image.
        ImageURLProtocol.urlSession().dataTask(with: url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData),
                  let blocks = self.loadingResponses[url], error == nil else {
                      DispatchQueue.main.async {
                          completion(nil,0)
                      }
                      return
                  }
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
            for block in blocks {
                DispatchQueue.main.async {
                    block(image, self.getSectionNumberForImage(count: responseData.count))
                }
                return
            }
        }.resume()
    }
    
    private func getSectionNumberForImage(count: Int) -> Int {
        var section = 0
        let size = Double(count) / 1024
        switch size {
        case 0..<100:
            section = 0
        case 100..<250:
            section = 1
        case 250..<500:
            section = 2
        case 500...:
            section = 3
        default:
            section = 0
        }
        return section
    }
}
