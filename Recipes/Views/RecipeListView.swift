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
    @State private var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "isDarkMode")
    
    let alertTitle = "Oops... There was a network error"
    let categories: [String] = ["All", "American", "British", "Canadian", "French", "Italian", "Polish"]
    let categoryIcons: [String] = ["⭐️", "🍦", "🍪", "🍫", "🍰", "🍮", "🍨"]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: -15),
        GridItem(.flexible(), spacing: -15)
    ]
    
    var body: some View {
        if !recipeViewModel.isError {
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
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .refreshable {
                    await recipeViewModel.refreshRecipes()
                }
                .task {
                    await recipeViewModel.refreshRecipes()
                }
                .alert(alertTitle, isPresented: $recipeViewModel.isError) { }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: toggleDarkMode) {
                            Image(systemName: isDarkMode ? "sun.max" : "moon.fill")
                                .foregroundStyle(isDarkMode ? .yellow : .purple)
                                .bold()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            Task {
                                await recipeViewModel.refreshRecipes()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundStyle(isDarkMode ? .white : .black)
                                .bold()
                        }
                    }
                }
                .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        } else {
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
    
    var searchResults: [Recipe] {
        if searchText.isEmpty && selectedIndex == 0 {
            return recipeViewModel.recipes
        } else if !searchText.isEmpty {
            return recipeViewModel.recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            return recipeViewModel.recipes.filter { $0.cuisine.lowercased().contains(categories[selectedIndex].lowercased()) }
        }
    }
    
    private func toggleDarkMode() {
        isDarkMode.toggle()
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
}

#Preview {
    RecipeListView()
}
