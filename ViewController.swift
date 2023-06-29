
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var drinkButton: UIButton!
    @IBOutlet weak var mealButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpButtons()
    }
    
   // MARK: LinearGradient Main ViewController
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.gray.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
   // MARK: Button Shape
    func setUpButtons() {
        drinkButton.layer.cornerRadius = 20
        mealButton.layer.cornerRadius = 20
        drinkButton.clipsToBounds = true
        mealButton.clipsToBounds = true
        drinkButton.addTarget(self, action: #selector(tappDrinks), for: .touchUpInside)
        mealButton.addTarget(self, action: #selector(tappMeals), for: .touchUpInside)
    }
    
    // MARK: Sending To The Next Drink Screen
    @objc private func tappDrinks() {
        // Kako da posalje na sledeci ekran?!
        if let vc = UIStoryboard.init(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "DrinksViewController") as? DrinksViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Sending To The Next Meal Screen
    @objc private func tappMeals() {
        if let mvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealsViewController") as? MealsViewController {
            self.navigationController?.pushViewController(mvc, animated: true)
        }
    }
}






