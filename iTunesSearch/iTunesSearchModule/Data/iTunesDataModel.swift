//
//  iTunesDataModel.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 11.12.2021.
//

// MARK: - iTunes Model

struct ITunesDataModel: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result Model

struct Result: Codable {
    var screenshotUrls: [String]?
    var artistName: String?
}
