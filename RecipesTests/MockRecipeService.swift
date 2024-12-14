//
//  MockRecipeService.swift
//  RecipesTests
//
//  Created by Bruke Wondessen on 12/13/24.
//

import Foundation
@testable import Recipes

final class MockRecipeService: RecipeFetching {
    var shouldReturnError: Bool = false
    var mockRecipes: [Recipe] = []

    func fetchRecipes() async throws -> [Recipe] {
        if shouldReturnError {
            throw NetworkingErrors.invalidResponse
        }
        return mockRecipes
    }
}


