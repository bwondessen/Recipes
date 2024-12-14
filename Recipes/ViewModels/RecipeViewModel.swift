//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/11/24.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isError: Bool = false
    
    private let recipeService: RecipeFetching
    
    init(recipeService: RecipeFetching = RecipeService()) {
        self.recipeService = recipeService
    }
    
    func fetchRecipes() async {
        do {
            let fetchedRecipes = try await recipeService.fetchRecipes()
            
            DispatchQueue.main.async {
                if fetchedRecipes.isEmpty {
                    self.isError = true
                    self.recipes = []
                } else {
                    self.isError = false
                    self.recipes = fetchedRecipes
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.isError = true
                self.recipes = []
            }
        }
    }
}


