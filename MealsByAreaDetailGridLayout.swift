//
//  MealsByAreaDetailGridLayout.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 24.1.23..
//

import UIKit

class MealsByAreaDetailGridLayout: UICollectionViewFlowLayout {
    override init() {
           super.init()
           commonInitAreaDetail()
       }
       
       required init(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)!
           commonInitAreaDetail()
       }
       
       func commonInitAreaDetail() {
           self.itemSize = CGSize(width: 200, height: 200)
           self.minimumInteritemSpacing = 5
           self.minimumLineSpacing = 5
           self.sectionInset = .zero
           self.scrollDirection = .vertical
       }
}
