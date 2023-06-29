//
//  MealsByAreaTableViewCell.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 23.1.23..
//

import UIKit

class MealsByAreaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealAreaLabel: UILabel!
    
    static let mealByAreaIdentifier = "MealsByAreaTableViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: SetUp Meal By Area Cell
    func setUpMealByAreaCell(data: Meals1) {
        mealAreaLabel.text = data.strArea
    }
    
}
