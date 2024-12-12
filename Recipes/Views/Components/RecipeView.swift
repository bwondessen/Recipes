//
//  RecipeRowView.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/11/24.
//

import SwiftUI

struct RecipeView: View {
    let photo: String
    let name: String
    let cuisine: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            RecipeImageView(url: URL(string: photo)!)
                .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.17)
                .clipShape(.rect(cornerRadius: 5))
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.subheadline.bold())
                    .lineLimit(1)
                    .truncationMode(.tail)
                HStack {
                    Text(cuisine)
                        .font(.callout)
                        .foregroundStyle(.black.opacity(0.65))
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.45)
    }
}

#Preview {
    RecipeView(photo: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9d257442-51c8-45c7-807a-e6132baa8fce/large.jpg", name: "New York Cheesecake", cuisine: "American")
}
