//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/11/24.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [Recipe]()
    
    func fetchRecipes() async throws {
        let endpoint: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkingErrors.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkingErrors.invalidResponse
            }
            
            if let data = try? JSONDecoder().decode(Recipes.self, from: data) {
                DispatchQueue.main.async {
                    self.recipes = data.recipes
                }
            }
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
}
