//
//  Meals.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 27.12.22..
//

import Foundation

//MARK: Meal Model 
struct MealsModes: Codable {
    var meals: [Meals]
}
struct Meals: Codable {
    var strMeal: String?
    var strArea: String?
    var strMealThumb: String?
    var strSource: String?
    var strYoutube: String?
}
