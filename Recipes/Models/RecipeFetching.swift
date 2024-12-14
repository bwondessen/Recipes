//
//  RecipeFetching.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/13/24.
//

import Foundation

protocol RecipeFetching {
    func fetchRecipes() async throws -> [Recipe]
}

struct RecipeService: RecipeFetching {
    
    private let endpoint: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: endpoint) else {
            throw NetworkingErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkingErrors.invalidResponse
        }
        
        do {
            let data = try JSONDecoder().decode(Recipes.self, from: data)
            return data.recipes
        } catch {
            throw NetworkingErrors.invalidData
        }
    }
}


