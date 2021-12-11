//
//  iTunesSearchDataProtocol.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 11.12.2021.
//

import Foundation

protocol iTunesSearchDataProtocol {
    
    typealias completion = (ITunesDataModel?, Error?) -> Void
    
    func fetchMedia(searchValue: String,
                    completion: @escaping completion)
    
}
