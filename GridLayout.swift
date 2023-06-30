//
//  GridLayout.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 2.12.22..

import UIKit
import Foundation

class GridLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.itemSize = CGSize(width: 100, height: 100)
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = 5
        self.sectionInset = .zero
        self.scrollDirection = .vertical 
    }
}
