//
//  HomeViewModel.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-07.
//

import CryptoKit
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var characters: [Character] = []

    func fetchCharacters() async throws {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let url =
            "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        guard let url = URL(string: url) else {
            fatalError("missing url")
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }

        do {
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(APIResponse.self, from: data)
            DispatchQueue.main.async {
                self.characters = apiResponse.data.results
            }
        } catch {
            fatalError("Error")
        }
    }

    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())

        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
