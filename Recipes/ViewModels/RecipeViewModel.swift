//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/11/24.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [Recipe]()
    @Published var isError: Bool = false
    
    func fetchRecipes() async throws {
        let endpoint: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        guard let url = URL(string: endpoint) else {
            DispatchQueue.main.async {
                self.isError = true
            }
            throw NetworkingErrors.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.isError = true
                }
                throw NetworkingErrors.invalidResponse
            }
            
            do {
                let data = try JSONDecoder().decode(Recipes.self, from: data)
                
                DispatchQueue.main.async {
                    if data.recipes.isEmpty {
                        self.isError = true // No recipes
                    } else {
                        self.recipes = data.recipes
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isError = true
                }
                throw NetworkingErrors.invalidData
            }
        } catch {
            DispatchQueue.main.async {
                self.isError = true
            }
            throw NetworkingErrors.invalidURL
        }
    }
    
    func refreshRecipes() async {
            do {
                try await fetchRecipes()
            } catch {
                DispatchQueue.main.async {
                    self.isError = true
                }
            }
        }
}
