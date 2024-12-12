//
//  RecipeListView.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/11/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var recipeViewModel: RecipeViewModel = RecipeViewModel()
    
    @State private var path: [String] = [String]()
    
    @State private var showAlert: Bool = false
    let alertTitle = "Oops... There was a network error"
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: -15),
        GridItem(.flexible(), spacing: -15)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(recipeViewModel.recipes) { recipe in
                        RecipeRowView(photo: recipe.photoURLLarge, name: recipe.name, cuisine: recipe.cuisine)
                    }
                }
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
            }
        }
        .task {
            do {
                try await recipeViewModel.fetchRecipes()
            } catch {
                showAlert = true
            }
        }
        .alert(alertTitle, isPresented: $showAlert) { }
    }
}

#Preview {
    RecipeListView()
}
