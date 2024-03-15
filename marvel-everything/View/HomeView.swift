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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(vm.characters) { character in
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
            }.padding(20)
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
