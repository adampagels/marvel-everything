//
//  HomeModel.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-09.
//

import Foundation

struct APIResponse: Codable {
    let data: APICharacterData
}

struct APICharacterData: Codable {
    let count: Int
    let results: [Character]
}

struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: [String: String]
}
