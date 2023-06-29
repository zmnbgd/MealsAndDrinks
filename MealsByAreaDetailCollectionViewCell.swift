//
//  MealsByAreaDetailCollectionViewCell.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 23.1.23..
//

import UIKit
import Kingfisher

class MealsByAreaDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var areaMealImage: UIImageView!
    @IBOutlet weak var areaMealName: UILabel!
    @IBOutlet weak var areaLineView: UIView!
    
    static let areaMealsDetailIdentifier = "MealsByAreaDetailCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setUpMelasByAreaDetailCell(data: Meals) {
        areaMealName.text = data.strMeal
    }
    
    func setUpAreaMealsDetailCell(data: Meals) {
        areaMealName.text = data.strMeal
        let imageUrl = URL(string: data.strMealThumb ?? "")
        areaMealImage.kf.setImage(with: imageUrl)
    }
}


