//
//  RecipesViewModelTests.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 05/06/23.
//

import Foundation
import XCTest
@testable import YapeRecipesChallenge

class RecipesViewModelTests: XCTestCase {

    var sut: RecipesViewModel!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    internal func createViewModel() -> RecipesViewModel {
        return RecipesViewModel()
    }
    
    func test_filteredRecipes_emptySearchText() {
        // Given
        let recipes = getMockRecipes()
        sut = createViewModel()
        sut.recipes = recipes
        sut.searchText = ""
        
        // When
        let filteredRecipes = sut.filteredRecipes()
        
        // Then
        XCTAssertEqual(filteredRecipes, recipes)
    }
    
    func test_filteredRecipes_searchText_ingredients() {
        // Given
        let recipes = getMockRecipes()
        sut = createViewModel()
        sut.recipes = recipes
        sut.searchText = "rice"
        var filteredRecipes: [Recipe]!
        
        // When
        filteredRecipes = sut.filteredRecipes()
        
        // Then
        XCTAssertNotNil(filteredRecipes)
        XCTAssertEqual(filteredRecipes.count, 1)
        XCTAssertEqual(filteredRecipes.first?.name, "Sushi Rolls")
    }

    func test_filteredRecipes_searchText() {
        // Given
        let recipes = getMockRecipes()
        sut = createViewModel()
        sut.recipes = recipes
        sut.searchText = "hamburger"
        var filteredRecipes: [Recipe]!
        
        // When
        filteredRecipes = sut.filteredRecipes()
        
        // Then
        XCTAssertNotNil(filteredRecipes)
        XCTAssertEqual(filteredRecipes.count, 1)
        XCTAssertEqual(filteredRecipes.first?.name, "Hamburger")
    }

    internal func getMockRecipes() -> [Recipe] {
        return [
            Recipe(
                name: "Hamburger",
                description: "Indulge in the ultimate American classic, the Hamburger. This iconic dish from the United States is a symphony of flavors and textures that will leave your taste buds craving for more.",
                origin: RecipeOrigin(
                    country: "United States",
                    flagIcon: "🇺🇸",
                    city: "Washington D.C."),
                ingredients: [
                        "1/2 lb ground beef",
                        "Hamburger buns",
                        "Lettuce",
                        "Tomato slices",
                        "Onion slices",
                        "Pickles",
                        "Ketchup",
                        "Mustard",
                        "Salt",
                        "Black pepper"
                ],
                steps: [
                    "Preheat a grill or stovetop skillet over medium-high heat.",
                    "Divide the ground beef into patties and season them with salt and black pepper.",
                    "Cook the patties for about 4-5 minutes per side, or until desired doneness.",
                    "Toast the hamburger buns on the grill or skillet.",
                    "Place the cooked patties on the bottom half of each bun.",
                    "Layer lettuce, tomato slices, onion slices, and pickles on top of the patties.",
                    "Spread ketchup and mustard on the top half of the buns.",
                    "Place the top bun over the fillings to complete the hamburger.",
                    "Serve hot with fries or a side of your choice."
                ],
                servings: "1 hamburger",
                prepTime: "20 minutes",
                imageURL: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1998&q=80"),
            Recipe(
                name: "Sushi Rolls",
                description: "Embark on a culinary adventure with these delectable Sushi Rolls straight from the heart of Japan. Crafted with care and precision, each roll is a work of art that combines the perfect harmony of flavors and textures. Enjoy!",
                origin: RecipeOrigin(
                    country: "Japan",
                    flagIcon: "🇯🇵",
                    city: "Tokyo"),
                ingredients: [
                    "Sushi rice",
                    "Nori seaweed sheets",
                    "Assorted fillings (e.g., cucumber, avocado, raw fish)",
                    "Soy sauce",
                    "Pickled ginger",
                    "Wasabi"
                ],
                steps: [
                    "Cook sushi rice according to the package instructions.",
                    "Place a sheet of nori on a bamboo sushi mat.",
                    "Spread a thin layer of sushi rice over the nori, leaving a 1-inch border at the top.",
                    "Add your desired fillings (e.g., cucumber, avocado, raw fish) in a line across the center of the rice.",
                    "Using the sushi mat, roll the nori tightly around the fillings.",
                    "Moisten the top border of the nori with water to seal the roll.",
                    "Slice the roll into bite-sized pieces using a sharp knife.",
                    "Serve with soy sauce, pickled ginger, and wasabi."
                ],
                servings: "Varies",
                prepTime: "45 minutes",
                imageURL: "https://images.unsplash.com/photo-1564489563601-c53cfc451e93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHN1c2hpJTIwcm9sbHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60")
        ]
    }
}
