//
//  MealsDetailViewController.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 13.1.23..
//

import UIKit
import WebKit
import Kingfisher
import Alamofire
import SwiftyJSON

class MealsDetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var meal: [Meals] = []
    var randomMeal: Bool = false
    var meals2: [Meals] = []
   
    
    override func loadView() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    var selectedMeals: Meals?
    var searchRandomMealVideo: Meals?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMealsDetails()
        randomSearchMealDetail()
        searchMelasVideo()
        searchRandomMeal()
        areaMealsDetailYoutubeVideo(name: selectedMeals?.strMeal ?? "")
    }
    //MARK: Presenting YouTube Video in MealsDetailViewController 
    private func setUpMealsDetails() {
        title = selectedMeals?.strMeal
        if let url = URL(string: selectedMeals?.strYoutube ?? "") {
            webView.load(URLRequest(url: url))
       }
    }
    //MARK: Presenting Random Search Meal
    private func randomSearchMealDetail() {
        title = searchRandomMealVideo?.strMeal
        if let url = URL(string: searchRandomMealVideo?.strYoutube ?? "") {
            webView.load(URLRequest(url: url))
        }
    }
    //MARK: Presenting Search Meal 
    private func searchMelasVideo() {
        title = meals2.first?.strMeal
        if let url = URL(string: meals2.first?.strYoutube ?? "") {
            webView.load(URLRequest(url: url))
        }
    }
}
//MARK: Get API With Alamofire Mail Detail Video
extension MealsDetailViewController {
    func areaMealsDetailYoutubeVideo(name: String) {
        let url = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(name)"
        let capUrl = url.replacingOccurrences(of: " ", with: "%20")
        Alamofire.request(capUrl, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                self.meals2.removeAll()
                do {
                    let myResult = try? JSON(data: response.data!)
                    for item in myResult!["meals"].arrayValue {
                        let name = item["strMeal"].stringValue
                        let area = item["strArea"].stringValue
                        let mealThumb = item["strMealThumb"].stringValue
                        let source = item["strSource"].stringValue
                        let youTube = item["strYoutube"].stringValue
                        self.meals2.append(Meals.init(strMeal: name, strArea: area, strMealThumb: mealThumb, strSource: source, strYoutube: youTube))
                    }
                    self.searchMelasVideo()
                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "Error"
                alert.show()
            }
        }
    }
}

//MARK: Get API With Alamofire Search Meal
extension MealsDetailViewController {
    func searchRandomMeal() {
        let url = "https://www.themealdb.com/api/json/v1/1/random.php"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                self.meals2.removeAll()
                do {
                    let myRadomResult = try? JSON(data: response.data!)
                    for item in myRadomResult!["meals"].arrayValue {
                        let youtube = item["strYoutube"].stringValue
                        self.meals2.append(Meals.init(strYoutube: youtube))
                    }
                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "Something went wrong"
                alert.show()
            }
        }
    }
}


