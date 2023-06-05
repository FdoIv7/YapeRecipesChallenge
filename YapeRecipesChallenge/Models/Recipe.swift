//
//  Recipe.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 27/05/23.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let origin: RecipeOrigin
    let ingredients: [String]
    let steps: [String]
    let servings: String
    let prepTime: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case name, ingredients, steps, description, origin
        case servings = "serving_sizes"
        case prepTime = "prep_time"
        case imageURL = "image_url"
    }
}

struct RecipeOrigin: Codable {
    let country: String
    let flagIcon: String
    let city: String
}
/// Equatable extension for recipe, will help us compare recipes
extension RecipeResponse: Equatable {
    static func == (lhs: RecipeResponse, rhs: RecipeResponse) -> Bool {
        return lhs.recipes == rhs.recipes
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name &&
        lhs.origin == rhs.origin &&
        lhs.ingredients == rhs.ingredients &&
        lhs.servings == rhs.servings &&
        lhs.prepTime == rhs.prepTime &&
        lhs.imageURL == rhs.imageURL
    }
}

extension RecipeOrigin: Equatable {
    static func == (lhs: RecipeOrigin, rhs: RecipeOrigin) -> Bool {
        return lhs.city == rhs.city &&
        lhs.country == rhs.country &&
        lhs.flagIcon == rhs.flagIcon
    }
}
/*
 {
   "recipes": [
     {
       "name": "Pizza Margherita",
       "country": "Italy",
       "flag": "🇮🇹",
       "ingredients": [
         "1 pizza dough",
         "1/2 cup tomato sauce",
         "2 cups mozzarella cheese",
         "Fresh basil leaves",
         "Olive oil",
         "Salt"
       ],
       "steps": [
         "Preheat the oven to 475°F (245°C).",
         "Roll out the pizza dough into a thin circle.",
         "Spread the tomato sauce evenly on the dough.",
         "Sprinkle the mozzarella cheese over the sauce.",
         "Tear the fresh basil leaves and distribute them on top.",
         "Drizzle olive oil and sprinkle salt over the pizza.",
         "Bake in the preheated oven for 12-15 minutes, or until the crust is golden and the cheese is bubbly and slightly browned.",
         "Remove from the oven, let it cool for a few minutes, and serve."
       ],
       "serving_sizes": "1 large pizza",
       "prep_time": "30 minutes",
       "image_url": "https://example.com/pizza_margherita.jpg"
     },
     {
       "name": "Sushi Rolls",
       "country": "Japan",
       "flag": "🇯🇵",
       "ingredients": [
         "Sushi rice",
         "Nori seaweed sheets",
         "Assorted fillings (e.g., cucumber, avocado, raw fish)",
         "Soy sauce",
         "Pickled ginger",
         "Wasabi"
       ],
       "steps": [
         "Cook sushi rice according to the package instructions.",
         "Place a sheet of nori on a bamboo sushi mat.",
         "Spread a thin layer of sushi rice over the nori, leaving a 1-inch border at the top.",
         "Add your desired fillings (e.g., cucumber, avocado, raw fish) in a line across the center of the rice.",
         "Using the sushi mat, roll the nori tightly around the fillings.",
         "Moisten the top border of the nori with water to seal the roll.",
         "Slice the roll into bite-sized pieces using a sharp knife.",
         "Serve with soy sauce, pickled ginger, and wasabi."
       ],
       "serving_sizes": "Varies",
       "prep_time": "45 minutes",
       "image_url": "https://example.com/sushi_rolls.jpg"
     },
     {
       "name": "Hamburger",
       "country": "United States",
       "flag": "🇺🇸",
       "ingredients": [
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
       "steps": [
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
       "serving_sizes": "1 hamburger",
       "prep_time": "20 minutes",
       "image_url": "https://example.com/hamburger.jpg"
     },
     {
       "name": "Pad Thai",
       "country": "Thailand",
       "flag": "🇹🇭",
       "ingredients": [
         "8 oz rice noodles",
         "1/4 cup tamarind paste",
         "3 tbsp fish sauce",
         "2 tbsp sugar",
         "2 tbsp vegetable oil",
         "2 cloves garlic, minced",
         "8 oz shrimp, peeled and deveined",
         "2 eggs, beaten",
         "1 cup bean sprouts",
         "1/4 cup chopped peanuts",
         "2 green onions, chopped",
         "Lime wedges",
         "Cilantro leaves"
       ],
       "steps": [
         "Soak the rice noodles in warm water for 10-15 minutes until softened. Drain and set aside.",
         "In a small bowl, whisk together tamarind paste, fish sauce, and sugar. Set aside.",
         "Heat vegetable oil in a large skillet or wok over medium heat.",
         "Add minced garlic and cook for 1 minute until fragrant.",
         "Add shrimp and cook until pink and cooked through, about 2-3 minutes.",
         "Push the shrimp to one side of the skillet and pour the beaten eggs into the other side. Scramble the eggs until cooked.",
         "Add the drained rice noodles to the skillet and pour the tamarind sauce over them.",
         "Toss everything together until the noodles are evenly coated in the sauce.",
         "Add bean sprouts, chopped peanuts, and green onions. Toss again to combine.",
         "Remove from heat and garnish with lime wedges and cilantro leaves.",
         "Serve hot and enjoy!"
       ],
       "serving_sizes": "2-3 servings",
       "prep_time": "30 minutes",
       "image_url": "https://example.com/pad_thai.jpg"
     },
     {
       "name": "Croissant",
       "country": "France",
       "flag": "🇫🇷",
       "ingredients": [
         "2 1/4 cups all-purpose flour",
         "1/4 cup granulated sugar",
         "1/2 tsp salt",
         "1 1/4 cups unsalted butter, cold",
         "1/2 cup cold water",
         "1 large egg, beaten (for egg wash)",
         "Chocolate (optional)"
       ],
       "steps": [
         "In a large mixing bowl, whisk together flour, sugar, and salt.",
         "Cut the cold butter into small cubes and add them to the flour mixture.",
         "Using a pastry cutter or your hands, cut the butter into the flour until the mixture resembles coarse crumbs.",
         "Make a well in the center and pour in the cold water.",
         "Mix the dough until it comes together, then turn it out onto a floured surface.",
         "Knead the dough for about 5 minutes until smooth and elastic.",
         "Shape the dough into a rectangle and wrap it in plastic wrap.",
         "Chill the dough in the refrigerator for at least 1 hour, or overnight.",
         "Remove the dough from the refrigerator and let it sit at room temperature for a few minutes.",
         "Roll out the dough into a large rectangle, then fold it into thirds like a letter.",
         "Turn the dough 90 degrees and repeat the rolling and folding process two more times.",
         "Wrap the folded dough in plastic wrap and refrigerate for 30 minutes.",
         "Preheat the oven to 400°F (200°C).",
         "Roll out the chilled dough into a large rectangle, about 1/4-inch thick.",
         "Cut the dough into triangles and roll each triangle from the wide end to the tip.",
         "Place the rolled croissants on a baking sheet lined with parchment paper.",
         "Brush the croissants with beaten egg for a shiny finish.",
         "Bake in the preheated oven for 15-20 minutes, or until golden brown.",
         "If desired, melt some chocolate and drizzle it over the baked croissants.",
         "Let the croissants cool on a wire rack before serving."
       ],
       "serving_sizes": "8 croissants",
       "prep_time": "2 hours 30 minutes",
       "image_url": "https://example.com/croissant.jpg"
     }
   ]
 }

 
 */
