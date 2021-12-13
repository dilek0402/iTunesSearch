//
//  iTunesDataModel.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 11.12.2021.
//

import UIKit

// MARK: - iTunes Model

struct ITunesDataModel: Codable {
    var resultCount: Int
    var results: [Result]
}

// MARK: - Result Model

struct Result: Codable {
    var screenshotUrls: [String]?
    var artistName: String?
}

// MARK: - Image Model

struct iTunesImages  {
    var screenshots: [UIImage]?
    var sectionName: String?
}
