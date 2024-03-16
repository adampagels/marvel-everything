//
//  CharacterDetailModel.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-16.
//

import Foundation

struct APIComicResponse: Codable {
    let data: APIComicData
}

struct APIComicData: Codable {
    let count: Int
    let results: [Comic]
}

struct Comic: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: [String: String]
}
