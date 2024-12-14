//
//  RecipeListView.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/11/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var recipeViewModel: RecipeViewModel = RecipeViewModel()
    
    @State private var searchText: String = ""
    @State private var selectedIndex: Int = 0
    @State private var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "isDarkMode")
    
    let categories: [String] = ["All", "American", "British", "Canadian", "French", "Italian", "Polish"]
    let categoryIcons: [String] = ["⭐️", "🍦", "🍪", "🍫", "🍰", "🍮", "🍨"]
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if recipeViewModel.isError {
                    ErrorView()
                } else {
                    CategoriesView(categories: categories, categoryIcons: categoryIcons, selectedIndex: $selectedIndex, searchText: $searchText)
                    
                    VStack {
                        Spacer().frame(height: 12)
                        
                        RecipeGridView(recipes: searchResults, columns: columns)
                    }
                    .padding([.leading, .trailing], 16)
                    .padding(.top, 16)
                    
                    .navigationTitle("Recipes")
                    .navigationBarTitleDisplayMode(.inline)
                    .scrollContentBackground(.hidden)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable {
                await recipeViewModel.fetchRecipes()
            }
            .task {
                await recipeViewModel.fetchRecipes()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DarkModeToggleButton(isDarkMode: $isDarkMode)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    RefreshButton(recipeViewModel: recipeViewModel)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
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

struct ErrorView: View {
    var body: some View {
        VStack {
            Image("ErrorImage")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
            
            Text("There was a network error...")
                .font(.system(.headline, design: .serif))
            
            Text("Our team is currently working to resolve the issue!")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct CategoriesView: View {
    let categories: [String]
    let categoryIcons: [String]
    @Binding var selectedIndex: Int
    @Binding var searchText: String
    
    var body: some View {
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
            .padding([.leading, .trailing], 16)
        }
    }
}

struct RecipeGridView: View {
    let recipes: [Recipe]
    let columns: [GridItem]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 25) {
            ForEach(recipes) { recipe in
                RecipeView(photo: recipe.photoURLLarge, name: recipe.name, cuisine: recipe.cuisine, youtubeURL: recipe.youtubeURL ?? "https://youtube.com", sourceURL: recipe.sourceURL ?? "https://google.com")
            }
        }
    }
}

struct DarkModeToggleButton: View {
    @Binding var isDarkMode: Bool
    
    var body: some View {
        Button(action: toggleDarkMode) {
            Image(systemName: isDarkMode ? "sun.max" : "moon.fill")
                .foregroundStyle(isDarkMode ? .yellow : .purple)
                .bold()
        }
    }
    
    private func toggleDarkMode() {
        isDarkMode.toggle()
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
}

struct RefreshButton: View {
    let recipeViewModel: RecipeViewModel
    
    var body: some View {
        Button {
            Task {
                await recipeViewModel.fetchRecipes()
            }
        } label: {
            Image(systemName: "arrow.clockwise")
                .foregroundStyle(.black)
                .bold()
        }
    }
}

#Preview {
    RecipeListView()
}






