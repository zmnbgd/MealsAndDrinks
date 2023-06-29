//
//  MealsByAreaModel.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 17.1.23..
//

import Foundation

//MARK: Meals By Area Model
struct AreaByMeals: Codable {
    var meals: [Meals1]
    
}
struct Meals1: Codable {
    var strArea: String?
}
