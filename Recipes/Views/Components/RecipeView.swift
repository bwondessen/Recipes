//
//  RecipeView.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/11/24.
//

import SwiftUI

struct RecipeView: View {
    let photo: String
    let name: String
    let cuisine: String
    let youtubeURL: String
    let sourceURL: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            RecipeImageWithMenuView(photo: photo, youtubeURL: youtubeURL, sourceURL: sourceURL)
            RecipeTextView(name: name, cuisine: cuisine)
        }
        .frame(maxWidth: .infinity)
    }
}

struct RecipeImageWithMenuView: View {
    let photo: String
    let youtubeURL: String
    let sourceURL: String
    
    var body: some View {
        RecipeImageView(url: URL(string: photo)!)
            .frame(maxWidth: .infinity, maxHeight: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Menu {
                            Link(destination: URL(string: youtubeURL)!) {
                                Label("YouTube", systemImage: "play.rectangle.fill")
                            }
                            Link(destination: URL(string: sourceURL)!) {
                                Label("Safari", systemImage: "safari")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .padding(5)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                .padding(10)
                        }
                    }
                }
            )
    }
}

struct RecipeTextView: View {
    let name: String
    let cuisine: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline.bold())
                .lineLimit(1)
                .accessibilityLabel("\(name) recipe")
            Text(cuisine)
                .font(.callout)
                .foregroundStyle(.gray)
                .accessibilityLabel("\(cuisine) cuisine")
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    RecipeView(
        photo: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9d257442-51c8-45c7-807a-e6132baa8fce/large.jpg",
        name: "New York Cheesecake",
        cuisine: "American",
        youtubeURL: "https://youtube.com",
        sourceURL: "https://google.com"
    )
}


