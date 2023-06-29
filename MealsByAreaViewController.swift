//
//  MealsByAreaViewController.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 17.1.23..
//

import UIKit
import Alamofire
import SwiftyJSON

class MealsByAreaViewController: UIViewController {
    
    @IBOutlet weak var mealsByAreaTableView: UITableView!

    var selectedMealsByArea: Meals1?
    var dataMealsByArea: [AreaByMeals] = []
    
    var mealsArea: [Meals1] = [] {
        didSet {
            self.mealsByAreaTableView.reloadData()
        }
    }
    
    var mealsAreaDetail: [Meals] = [] {
        didSet {
            self.mealsByAreaTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMealsByArea()
        searchMealsByArea()
    }
}

//MARK: Private Methods
extension MealsByAreaViewController {
    private func setUpMealsByArea() {
        setUpMealsByAreaDelegate()
        setUpMealsByAreaTableViewCollection()
    }
    private func setUpMealsByAreaDelegate() {
        mealsByAreaTableView.delegate = self
        mealsByAreaTableView.dataSource = self
    }
    private func setUpMealsByAreaTableViewCollection() {
        let nib = UINib(nibName: MealsByAreaTableViewCell.mealByAreaIdentifier, bundle: nil)
        mealsByAreaTableView.register(nib, forCellReuseIdentifier: MealsByAreaTableViewCell.mealByAreaIdentifier)
        mealsByAreaTableView.rowHeight = 60
    }
}

// MARK: Presenting Meals By Area Data In TableViewCell
extension MealsByAreaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsArea.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealsByAreaTableViewCell.mealByAreaIdentifier, for: indexPath) as? MealsByAreaTableViewCell else {
            return UITableViewCell()
        }
        let item = mealsArea[indexPath.row]
        cell.setUpMealByAreaCell(data: item)
        return cell
    }
}

//MARK: Interaction With Meal By Area TableViewCell
extension MealsByAreaViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMealArea = mealsArea[indexPath.row]
        if let amvc = storyboard?.instantiateViewController(withIdentifier: "MealsByAreaDetailViewController") as? MealsByAreaDetailViewController {
            amvc.selectedArea = selectedMealArea
            self.navigationController?.pushViewController(amvc, animated: true)
        }
    }
}

// MARK: Get API Call With Alamofire Search Meals By Area
extension MealsByAreaViewController {
    func searchMealsByArea() {
        let url = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                self.mealsArea.removeAll()
                do {
                    let myResult = try? JSON(data: response.data!)
                    for item in myResult!["meals"].arrayValue {
                        let name = item["strArea"].stringValue
                        self.mealsArea.append(Meals1.init(strArea: name))
                    }
                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "no internet connection"
                alert.show()
            }
        }
    }
}
