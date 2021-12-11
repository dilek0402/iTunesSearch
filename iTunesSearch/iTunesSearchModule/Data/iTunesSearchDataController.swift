//
//  iTunesSearchDataController.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 10.12.2021.
//

import Foundation

final class iTunesSearchDataController: iTunesSearchDataProtocol {
    
    func fetchMedia(searchValue: String,
                    completion: @escaping (ITunesDataModel?, Error?) -> Void) {
        let urlString = NetworkConfiguration.basePath +
        NetworkConfiguration.searchPath +
        searchValue + NetworkConfiguration.path
        let url = URL(string: urlString)!
        let task = URLSession.shared.sendRequest(url: url,
                                                 completionHandler: { (result: ITunesDataModel?, response, error) in
            if let error = error {
                completion(nil, error)
            }
            completion(result, nil)
        })
        task.resume()
        
    }
}
