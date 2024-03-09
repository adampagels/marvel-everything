//
//  HomeView.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-07.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = CharacterViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        List {
            ForEach(vm.characters) { character in
                Text(character.name)
            }
        }.task {
            do {
                try await vm.fetchCharacters()
            } catch {}
        }
    }
}

#Preview {
    HomeView()
}
