
import UIKit
import Alamofire
import SwiftyJSON

class DrinksViewController: UIViewController {
    
    @IBOutlet weak var drinksCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var data: [DrinksModel] = []
    var drinks: [Drinks] = [] {
        didSet {
            self.drinksCollectionView.reloadData()
        }
    }
    var drinks2: [Drinks] = [] {
        didSet {
            self.drinksCollectionView.reloadData()
        }
    }
    
    var drinks3: [Drinks] = []

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    //MARK: Search Coctail By Name
    @objc func searchCoctailByName(_ textField: UITextField) {
        searchDrinksName(coctail: searchTextField.text ?? "")
    }
    
    //MARK: Random Coctail Button 
    @IBAction func randomCoctail(_ sender: UIButton) {
       // print("radom coctail")
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailViewController") as? DrinkDetailViewController {
            dvc.isRandom = true
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

//MARK: - Private Methods
extension DrinksViewController {
    private func setUp() {
        setupDelegate()
        setUpCollection()
        drinkFetch()
        searchTextField.addTarget(self, action: #selector(searchCoctailByName), for: .editingChanged)
    }
    
    private func setupDelegate() {
        drinksCollectionView.delegate = self
        drinksCollectionView.dataSource = self
    }
    
    private func setUpCollection() {
        let nib = UINib(nibName: DrinkCollectionViewCell.identifier, bundle: nil)
        drinksCollectionView!.register(nib, forCellWithReuseIdentifier: DrinkCollectionViewCell.identifier)
        drinksCollectionView.collectionViewLayout = GridLayout()
    }
}

// MARK: Interaction with the cell
extension DrinksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // print("Tap")
        let selectedDrink = drinks[indexPath.row]
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailViewController") as? DrinkDetailViewController {
            dvc.selectedDrink = selectedDrink
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

//MARK: - UICollection View Data Source
extension DrinksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.identifier, for: indexPath) as? DrinkCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = drinks[indexPath.row]
        cell.setupCell(data: item)
        return cell
    }
}

//MARK: Get API Call With Alamofire
extension DrinksViewController {
    func drinkFetch() {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=A"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                self.drinks.removeAll()
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
                        self.drinks.append(Drinks.init(strCategory: name, strInstructions: instruction, strGlass: glass, strDrinkThumb: drinkThumb, strIngredient1: ingredient1, strIngredient2: ingredient2, strIngredient3: ingredient3, strIngredient4: ingredient4, strIngredient5: ingredient5, strIngredient6: ingredient6, strIngredient7: ingredient7, strMeasure1: measure1, strMeasure2: measure2, strMeasure3: measure3, strMeasure4: measure4, strMeasure5: measure5, strMeasure6: measure6, strMeasure7: measure7))
                    }
                    
                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "No internet conection!"
                alert.show()
            }
        }
    }
}

//MARK: CollectioView Cell GridLayout
extension DrinksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
           _ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize {
           let layout = collectionViewLayout as! GridLayout

           let availableWidth = collectionView.bounds.size.width
           let columns = 2
           var itemTotalWidth = availableWidth - CGFloat(columns) * layout.minimumInteritemSpacing
           itemTotalWidth -= (layout.sectionInset.left + layout.sectionInset.right)

           let itemWidth = itemTotalWidth / CGFloat(columns)
           let itemHeight = itemWidth * 1.3
           return CGSize(width: itemWidth, height: itemHeight)
       }
}

//MARK: Get API for Coctail Search
extension DrinksViewController {    
    func searchDrinksName(coctail: String?) {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
        let finalUrl = url + (coctail ?? "")
        Alamofire.request(finalUrl, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                self.drinks.removeAll()
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
                        self.drinks.append(Drinks.init(strCategory: name, strInstructions: instruction, strGlass: glass, strDrinkThumb: drinkThumb, strIngredient1: ingredient1, strIngredient2: ingredient2, strIngredient3: ingredient3, strIngredient4: ingredient4, strIngredient5: ingredient5, strIngredient6: ingredient6, strIngredient7: ingredient7, strMeasure1: measure1, strMeasure2: measure2, strMeasure3: measure3, strMeasure4: measure4, strMeasure5: measure5, strMeasure6: measure6, strMeasure7: measure7))
                    }
                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "No internet conection!"
                alert.show()
            }
        }
    }
}

//MARK: Get API Call From Random Coctail
extension DrinksViewController {
    func searchRandomCoctail() {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                self.drinks3.removeAll()
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

                }
            case .failure:
                let alert = UIAlertView()
                alert.title = "No internet conection!"
                alert.show()
            }
        }
    }
}
