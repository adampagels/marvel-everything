//
//  CharacterDetailScreen.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-15.
//

import SwiftUI

struct CharacterDetailScreen: View {
    @StateObject private var vm = CharacterDetailViewModel()

    let character: Character

    let size: CGFloat = 180
    @Environment(\.displayScale) var scale

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: character.thumbnail["path"]! + "." + character
                    .thumbnail["extension"]!))
            { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color.gray
                        ProgressView()
                    }
                case let .success(image):

                    image.resizable()

                case let .failure(error):
                    Text(error.localizedDescription)

                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: .infinity, height: scale * size / 1.8)
            VStack(alignment: .leading) {
                Text(character.name).font(.title)
                Text(character.description)

                Text("Comics").font(.title)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(vm.comics) { comic in
                            NavigationLink {
//                                HomeView()
                            } label: {
                                ComicView(comic: comic)
                            }
                        }
                    }
                }
            }
        }.task {
            do {
                try await vm.fetchComicsByCharacter(characterID: character.id)
            } catch {}
        }
    }
}

#Preview {
    CharacterDetailScreen(character: Character(
        id: 1_017_100,
        name: "A-Bomb (HAS)",
        description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!",
        thumbnail: [
            "extension": "jpg",
            "path": "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
        ]
    ))
}
