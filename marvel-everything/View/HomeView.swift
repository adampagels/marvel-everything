//
//  HomeView.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-07.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = CharacterViewModel()
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
                            CharacterDetailView(character: character)
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
    HomeView()
}
