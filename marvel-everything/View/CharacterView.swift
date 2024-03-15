//
//  CharacterView.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-08.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    @Environment(\.displayScale) var scale
    let size: CGFloat = 180
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.thumbnail["path"]! + "." + character
                           .thumbnail["extension"]!),
            scale: scale * size) { phase in
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
            .frame(width: size, height: size)
            HStack {
                Text(character.name)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Spacer()
            }
            .padding([.bottom, .leading], 5)
        }
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

#Preview {
    CharacterView(character: Character(id: 1017100, name: "A-Bomb (HAS)", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!", thumbnail: ["extension": "jpg", "path": "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16"]))
}

