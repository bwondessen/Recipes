//
//  NetworkingTests.swift
//  RecipesTests
//
//  Created by Bruke Wondessen on 12/13/24.
//

import XCTest
@testable import Recipes

final class RecipeViewModelTests: XCTestCase {
    private var viewModel: RecipeViewModel!
    private var mockService: MockRecipeService!
    
    override func setUp() {
        super.setUp()
        mockService = MockRecipeService()
        viewModel = RecipeViewModel(recipeService: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchRecipes_SuccessfulResponse() async {
        let mockRecipe = Recipe(
            id: "1",
            cuisine: "American",
            name: "New York Cheesecake",
            photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9d257442-51c8-45c7-807a-e6132baa8fce/large.jpg",
            photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9d257442-51c8-45c7-807a-e6132baa8fce/small.jpg",
            sourceURL: "https://www.bbcgoodfood.com/recipes/2869/new-york-cheesecake",
            uuid: "b63fbae1-f5d1-41a7-a030-1a3a556f4c57",
            youtubeURL: "https://www.youtube.com/watch?v=tspdJ6hxqnc"
        )
        mockService.mockRecipes = [mockRecipe]
        
        await viewModel.fetchRecipes()
        
        XCTAssertFalse(viewModel.isError)
    }
    
    func testFetchRecipes_EmptyResponse() async {
        mockService.mockRecipes = []
        
        await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.recipes.count, 0)
    }
    
    func testFetchRecipes_FailureResponse() async {
        mockService.shouldReturnError = true
        
        await viewModel.fetchRecipes()
        
        XCTAssertFalse(viewModel.isError)
    }
}

