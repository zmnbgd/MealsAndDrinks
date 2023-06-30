//
//  DrinkDetailViewController.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 5.12.22..
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class DrinkDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var drinkInstructions: UILabel!
    @IBOutlet weak var drinkGlass: UILabel!
    @IBOutlet weak var drinkIngredient: UILabel!
    @IBOutlet weak var drinkMeasure: UILabel!
    @IBOutlet weak var drinkMeasure2: UILabel!
    @IBOutlet weak var drinkMeasure3: UILabel!
    @IBOutlet weak var drinkMeasure4: UILabel!
    @IBOutlet weak var drinkMeasure5: UILabel!
    @IBOutlet weak var drinkMeasure6: UILabel!
    @IBOutlet weak var drinkMeasure7: UILabel!
    
   var selectedDrink: Drinks?
   var randomDrink: Drinks?
   var isRandom: Bool = false
   var drinks3: [Drinks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUp()
        multipleLineInstructions()
        if isRandom {
            searchRandomCoctail()
        } 
    }
    private func setUpData() {
        title = selectedDrink?.strCategory
        drinkCategory.text = selectedDrink?.strCategory
        drinkInstructions.text = selectedDrink?.strInstructions
        drinkGlass.text = selectedDrink?.strGlass
        drinkIngredient.text = selectedDrink?.strIngredient1
        drinkMeasure.text = selectedDrink?.strMeasure1
        drinkMeasure2.text = selectedDrink?.strMeasure2
        drinkMeasure3.text = selectedDrink?.strMeasure3
        drinkMeasure4.text = selectedDrink?.strMeasure4
        drinkMeasure5.text = selectedDrink?.strMeasure5
        drinkMeasure6.text = selectedDrink?.strMeasure6
        drinkMeasure7.text = selectedDrink?.strMeasure7
        if let url = URL(string: selectedDrink?.strDrinkThumb ?? "") {
            drinkImage.kf.setImage(with: url)
        }
    }
    
    private func setUpRandom() {
        title = drinks3.first?.strCategory
        drinkCategory.text = drinks3.first?.strCategory
        drinkInstructions.text = drinks3.first?.strInstructions
        drinkGlass.text = drinks3.first?.strGlass
        drinkIngredient.text = drinks3.first?.strIngredient1
        drinkMeasure.text = drinks3.first?.strMeasure1
        drinkMeasure2.text = drinks3.first?.strMeasure2
        drinkMeasure3.text = drinks3.first?.strMeasure3
        drinkMeasure4.text = drinks3.first?.strMeasure4
        drinkMeasure5.text = drinks3.first?.strMeasure5
        drinkMeasure6.text = drinks3.first?.strMeasure6
        drinkMeasure7.text = drinks3.first?.strMeasure7
        if let url = URL(string: drinks3.first?.strDrinkThumb ?? "") {
            drinkImage.kf.setImage(with: url)
        }
    }
    
    private func setupRandomDrink() {
        drinkCategory.text = selectedDrink?.strCategory
    }
    
    private func setUp() {
        scrollView.isScrollEnabled = true
    }
    private func multipleLineInstructions() {
        drinkInstructions.numberOfLines = 0
    }
}
//MARK: Get API Call Random Search
extension DrinkDetailViewController {
    func searchRandomCoctail() {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                do {
                   let myresult = try? JSON(data: response.data!)
                    for item in myresult!["drinks"].arrayValue {
                        let name = item["strCategory"].stringValue
                        let instruction = item["strInstructions"].stringValue
                        let glass = item["strGlass"].stringValue
                        let drinkThumb = item["strDrinkThumb"].stringValue
                        let ingredient1 = item["strIngredient1"].stringValue
                        let ingredient2 = item["strIngredient2"].stringValue
                        let ingredient3 = item["strIngredient3"].stringValue
                        let ingredient4 = item["strIngredient4"].stringValue
                        let ingredient5 = item["strIngredient5"].stringValue
                        let ingredient6 = item["strIngredient6"].stringValue
                        let ingredient7 = item["strIngredient7"].stringValue
                        let measure1 = item["strMeasure1"].stringValue
                        let measure2 = item["strMeasure2"].stringValue
                        let measure3 = item["strMeasure3"].stringValue
                        let measure4 = item["strMeasure4"].stringValue
                        let measure5 = item["strMeasure5"].stringValue
                        let measure6 = item["strMeasure6"].stringValue
                        let measure7 = item["strMeasure7"].stringValue
                        self.drinks3.append(Drinks.init(strCategory: name, strInstructions: instruction, strGlass: glass, strDrinkThumb: drinkThumb, strIngredient1: ingredient1, strIngredient2: ingredient2, strIngredient3: ingredient3, strIngredient4: ingredient4, strIngredient5: ingredient5, strIngredient6: ingredient6, strIngredient7: ingredient7, strMeasure1: measure1, strMeasure2: measure2, strMeasure3: measure3, strMeasure4: measure4, strMeasure5: measure5, strMeasure6: measure6, strMeasure7: measure7))
                    }
                    self.setUpRandom()
                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "No internet conection!"
                alert.show()
            }
        }
    }
}
