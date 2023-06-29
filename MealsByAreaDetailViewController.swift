//
//  MealsByAreaDetailViewController.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 23.1.23..
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class MealsByAreaDetailViewController: UIViewController {
    
    @IBOutlet weak var areaMealsDetailCollectionView: UICollectionView!
    
    var selectedArea: Meals1?
    var detailMealData: [MealsModes] = []
    
    var areaDetailMeal: [Meals] = [] {
        didSet {
            self.areaMealsDetailCollectionView.reloadData()
        }
    }
    var meals2: [Meals] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMealsByAreaDetail()
    }
}

//MARK: Private Methods Melas By Area Detail -> List
extension MealsByAreaDetailViewController {
    private func setUpMealsByAreaDetail() {
        setUpMealsByAreaDetailDelegate()
        setUpMealsByAreaDetailCollection()
        mealsByAreaDetailFetch(areaMeals: selectedArea?.strArea ?? "")
    }
    private func setUpMealsByAreaDetailDelegate() {
        areaMealsDetailCollectionView.delegate = self
        areaMealsDetailCollectionView.dataSource = self
    }
    
    private func setUpMealsByAreaDetailCollection() {
        let nib = UINib(nibName: MealsByAreaDetailCollectionViewCell.areaMealsDetailIdentifier, bundle: nil)
        areaMealsDetailCollectionView!.register(nib, forCellWithReuseIdentifier: MealsByAreaDetailCollectionViewCell.areaMealsDetailIdentifier)
        areaMealsDetailCollectionView.collectionViewLayout = MealsByAreaDetailGridLayout()
    }
}

//MARK: Meals By Area Detail UICollection View Data Source
extension MealsByAreaDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areaDetailMeal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let areaMealsDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: MealsByAreaDetailCollectionViewCell.areaMealsDetailIdentifier, for: indexPath) as? MealsByAreaDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = areaDetailMeal[indexPath.row]
        areaMealsDetailCell.setUpAreaMealsDetailCell(data: item)
        return areaMealsDetailCell
    }
}

//MARK: Interaction With CollectioViewCell -> zakomentarisano
extension MealsByAreaDetailViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//print("tap")
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedMealVideo = areaDetailMeal[indexPath.row]
        if let wvc = storyboard?.instantiateViewController(withIdentifier: "MealsDetailViewController") as? MealsDetailViewController {
            wvc.selectedMeals = selectedMealVideo
            self.navigationController?.pushViewController(wvc, animated: true)
        }
    }
}

//MARK: Meals By Area Collection Cell GridLayout
extension MealsByAreaDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
           _ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize {
           let layout = collectionViewLayout as! MealsByAreaDetailGridLayout

           let availableWidth = collectionView.bounds.size.width
           let columns = 2
           var itemTotalWidth = availableWidth - CGFloat(columns) * layout.minimumInteritemSpacing
           itemTotalWidth -= (layout.sectionInset.left + layout.sectionInset.right)

           let itemWidth = itemTotalWidth / CGFloat(columns)
           let itemHeight = itemWidth * 1.3
           return CGSize(width: itemWidth, height: itemHeight)
       }
}

//MARK: Get API Call With Alamofire Meals By Area Detail
extension MealsByAreaDetailViewController {
    func mealsByAreaDetailFetch(areaMeals: String) {
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(areaMeals)"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    let myResult = try? JSON(data: response.data!)
                    for item in myResult!["meals"].arrayValue {
                        let name = item["strMeal"].stringValue
                        let area = item["strArea"].stringValue
                        let mealImage = item["strMealThumb"].stringValue
                        let youtube = item["strYoutube"].stringValue
                        self.areaDetailMeal.append(Meals.init(strMeal: name, strArea: area, strMealThumb: mealImage, strYoutube: youtube))
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


