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
    let youtuebURL: String
    let sourceURL: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack {
                RecipeImageView(url: URL(string: photo)!)
                    .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.20)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Menu {
                                    Link(destination: URL(string: youtuebURL)!) {
                                        HStack {
                                            Text("YouTube")
                                            Image(systemName: "play.rectangle.fill")
                                        }
                                    }
                                    Link(destination: URL(string: sourceURL)!) {
                                        HStack {
                                            Text("Safari")
                                            Image(systemName: "safari")
                                        }
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundStyle(.black)
                                        .padding(5)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                                        .padding(10)
                                }
                                .foregroundStyle(.primary)
                            }
                        }
                    )
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline.bold())
                    .lineLimit(1)
                    .truncationMode(.tail)
                HStack {
                    Text(cuisine)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            .foregroundStyle(.primary)
        }
        .frame(width: UIScreen.main.bounds.width * 0.45)
    }
}

#Preview {
    RecipeView(photo: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9d257442-51c8-45c7-807a-e6132baa8fce/large.jpg", name: "New York Cheesecake", cuisine: "American", youtuebURL: "https://youtube.com", sourceURL: "https://google.com")
}
