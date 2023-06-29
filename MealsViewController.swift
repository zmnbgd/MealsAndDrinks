//
//  MealsViewController.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 22.12.22..
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class MealsViewController: UIViewController {
    
    @IBOutlet weak var mealSearchTextField: UITextField!
    @IBOutlet weak var randomMealButton: UIButton!
    @IBOutlet weak var mealByAreaButton: UIButton!
    @IBOutlet weak var meals: UITableView!
    
    @IBOutlet var buttons: [UIButton]!

    var selectedMeal: Meals? 
    var data: [MealsModes] = []
    
    var meals1: [Meals] = [] {
        didSet {
            self.meals.reloadData()
        }
    }
    
    var meals2: [Meals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMeals()
        mealsFetch()
        //MARK: Collection / Func
        for button in buttons {
            button.layer.cornerRadius = 12
        }

        mealSearchTextField.layer.cornerRadius = 12
    }
    
    //MARK: Search Meals By Area Button Action - > protocol
    @objc private func tapMealsByArea() {
        if let mavc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealsByAreaViewController") as? MealsByAreaViewController {
            self.navigationController?.pushViewController(mavc, animated: true)
        }
    }
    
    //MARK: Search Random Meal Detail YouTube Video Action
    @IBAction func searchRandomMeal(_ sender: UIButton) {
        if let rvc = storyboard?.instantiateViewController(withIdentifier: "MealsDetailViewController") as? MealsDetailViewController {
            rvc.randomMeal = true
            self.navigationController?.pushViewController(rvc, animated: true)
        }
    }
    
    //MARK: Search Meals By Name
    @objc func searchMealsByName(_ textField: UITextField) {
        searchMeals(mealResult: mealSearchTextField.text ?? "")
    }
}

//MARK: Private Methods
extension MealsViewController {
    
    private func setUpMeals() {
        setUpDMealsDelegate()
        setUpTableViewCollection()
        setUpButton()
        mealSearchTextField.addTarget(self, action: #selector(searchMealsByName), for: .editingChanged)
    }
    
    private func setUpDMealsDelegate() {
        meals.delegate = self
        meals.dataSource = self
    }
    
    private func setUpTableViewCollection() {
        let nib = UINib(nibName: MealTableViewCell.mealCellIdentifier, bundle: nil)
        meals.register(nib, forCellReuseIdentifier: MealTableViewCell.mealCellIdentifier)
        meals.rowHeight = 200
    }
    
    private func setUpButton() {
        mealByAreaButton.addTarget(self, action: #selector(tapMealsByArea), for: .touchUpInside)
    }
}

//MARK: Presenting Meals Data in TableViewCell
extension MealsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.mealCellIdentifier, for: indexPath) as? MealTableViewCell else {
            return UITableViewCell()
        }
        let item = meals1[indexPath.row]
        cell.setUpMealCell(data: item)
        cell.delegate = self
        return cell
    }
}

//MARK: Interaction With TableViewCell
extension MealsViewController {
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMeal = meals1[indexPath.row]
        if let dmvc = storyboard?.instantiateViewController(withIdentifier: "MealsDetailViewController") as? MealsDetailViewController {
            dmvc.selectedMeals = selectedMeal
            self.navigationController?.pushViewController(dmvc, animated: true)
        }
    }
}

//MARK: Get API Call With Alamofire
extension MealsViewController {
    func mealsFetch() {
        let url = "https://www.themealdb.com/api/json/v1/1/search.php?s="
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                self.meals1.removeAll()
                do {
                    let myResult = try? JSON(data: response.data!)
                    for item in myResult!["meals"].arrayValue {
                        let name = item["strMeal"].stringValue
                        let area = item["strArea"].stringValue
                        let mealThumb = item["strMealThumb"].stringValue
                        let source = item["strSource"].stringValue
                        let youTube = item["strYoutube"].stringValue
                        self.meals1.append(Meals.init(strMeal: name, strArea: area, strMealThumb: mealThumb, strSource: source, strYoutube: youTube))
                    }
                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "No internet conection"
                alert.show()
            }
        }
    }
}

//MARK: Get API Call With Alamofire Search Meal By Name
extension MealsViewController {
    func searchMeals(mealResult: String) {
        let url = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(mealResult)"
        //let searchResult = url + (mealResult ?? "")
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                self.meals1.removeAll()
                do {
                    let mySearchResult = try? JSON(data: response.data!)
                    for item in mySearchResult!["meals"].arrayValue {
                        let name = item["strMeal"].stringValue
                        let area = item["strArea"].stringValue
                        let mealThumb = item["strMealThumb"].stringValue
                        let source = item["strSource"].stringValue
                        let youTube = item["strYoutube"].stringValue
                        self.meals1.append(Meals.init(strMeal: name, strArea: area, strMealThumb: mealThumb, strSource: source, strYoutube: youTube))
                    }
                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "Search error"
                alert.show()
            }
        }
    }
}

extension MealsViewController: MealTableViewCellDelegate {
    func selectSource(urlSource: Meals) {
        if let SourceVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SourceViewController") as? SourceViewController {
            SourceVC.source = urlSource
            self.navigationController?.pushViewController(SourceVC, animated: true)
        }
    }
}


