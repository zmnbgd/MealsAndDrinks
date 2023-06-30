
import UIKit
import Kingfisher

class DrinkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    static let identifier = "DrinkCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(data: Drinks) {
        drinkName.text = data.strCategory
        
        let imageUrl = URL(string: data.strDrinkThumb ?? "")
        drinkImage.kf.setImage(with: imageUrl)
    }
}

