//
//  MealTableViewCell.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 13.1.23..
//

import UIKit
import Kingfisher

protocol MealTableViewCellDelegate: AnyObject {
    func selectSource(urlSource: Meals)
}

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealAreaLabel: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var sourceButton: UIButton!
    
    var meal: Meals!
    
    static let mealCellIdentifier = "MealTableViewCell"
    
    weak var delegate: MealTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        sourceButton.addTarget(self, action: #selector(tapButtonSource), for: .touchUpInside)
    } 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: SetUp Cell Image And Labels
    func setUpMealCell(data: Meals) {
        meal = data
        mealNameLabel.text = data.strMeal
        mealAreaLabel.text = data.strArea
        let mealImageUr1 = URL(string: data.strMealThumb ?? "")
        mealImage.kf.setImage (with: mealImageUr1)
    }
    
    //MARK: Button Action
    @objc func tapButtonSource() {
        delegate?.selectSource(urlSource: meal)
    }
}
