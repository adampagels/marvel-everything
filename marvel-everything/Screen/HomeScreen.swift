//
//  HomeScreen.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-07.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var vm = HomeViewModel()
    @Environment(\.displayScale) var scale
    let size: CGFloat = 180

    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 30),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(vm.characters) { character in
                        NavigationLink {
                            CharacterDetailScreen(character: character)
                        } label: {
                            CharacterView(character: character)
                        }
                    }
                }.padding(20)
            }.task {
                do {
                    try await vm.fetchCharacters()
                } catch {}
            }
        }
    }
}

#Preview {
    HomeScreen()
}
