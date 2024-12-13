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
    @State private var searchText: String = ""
    @State private var selectedIndex: Int = 0
    @State private var showAlert: Bool = false
    
    let alertTitle = "Oops... There was a network error"
    let categories: [String] = ["All", "American", "British", "Canadian", "French", "Italian", "Polish"]
    let categoryIcons: [String] = ["⭐️", "🍦", "🍪", "🍫", "🍰", "🍮", "🍨"]
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: -15),
        GridItem(.flexible(), spacing: -15)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<categories.count, id: \.self) { i in
                            CategoryView(isActive: i == selectedIndex, category: categories[i], categoryIcon: categoryIcons[i])
                                .onTapGesture {
                                    selectedIndex = i
                                }
                                .onChange(of: searchText) {
                                    selectedIndex = !searchText.isEmpty ? 0 : selectedIndex
                                }
                        }
                    }
                    .padding()
                }
                
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(searchResults) { recipe in
                        RecipeView(photo: recipe.photoURLLarge, name: recipe.name, cuisine: recipe.cuisine, youtuebURL: recipe.youtubeURL ?? "https://youtube.com", sourceURL: recipe.sourceURL ?? "https://google.com")
                    }
                }
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
            }
            .searchable(text: $searchText)
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
    
    var searchResults: [Recipe] {
        if searchText.isEmpty && selectedIndex == 0 {
            return recipeViewModel.recipes
        } else if !searchText.isEmpty {
            return recipeViewModel.recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            return recipeViewModel.recipes.filter { $0.cuisine.lowercased().contains(categories[selectedIndex].lowercased()) }
        }
    }
}

#Preview {
    RecipeListView()
}
