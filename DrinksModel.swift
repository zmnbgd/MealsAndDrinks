
import Foundation

struct DrinksModel: Codable {
    var drinks: [Drinks]
}

struct Drinks: Codable {
    
    var strCategory: String?
    var strInstructions: String?
    var strGlass: String?
    var strDrinkThumb: String?
    var strDrink: String?
    
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    
}

