//
//  ComicView.swift
//  marvel-everything
//
//  Created by Adam Pagels on 2024-03-19.
//

import SwiftUI

struct ComicView: View {
    let comic: Comic
    @Environment(\.displayScale) var scale
    let size: CGFloat = 180

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: comic.thumbnail["path"]! + "." + comic
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
            .frame(width: size * 1.6, height: size * 2)
        }
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

#Preview {
    ComicView(comic: Comic(
        id: 47176,
        title: "FREE COMIC BOOK DAY 2013 1 (2013) #1",
        description: "",
        thumbnail: [
            "extension": "jpg",
            "path": "http://i.annihil.us/u/prod/marvel/i/mg/9/50/57ed5bc9040e3",
        ]
    ))
}
