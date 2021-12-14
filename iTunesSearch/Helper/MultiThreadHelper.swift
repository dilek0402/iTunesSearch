//
//  MultiThreadHelper.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 13.12.2021.
//

import Foundation
import UIKit

public class MultiThreadHelper {
        
    // MARK: - Properties
    
    public static let multiThread = MultiThreadHelper()
    
    // MARK: - Methods
    
    public final func downloadImage(imageList: [String], completion: @escaping (UIImage?, Int) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            imageList.forEach { item in
                guard let imageUrl = URL(string: item) else {
                    return
                }
                ImageCache.publicCache.load(url: imageUrl as NSURL) {  image, section in
                    if let image = image {
                        completion(image, section)
                    }
                }
            }
        }
    }
    
    public final func cancelable() {
        ImageCache.publicCache.cancalBlock()
    }
    
}
