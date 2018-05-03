import UIKit

class RestaurantViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(restaurant: Restaurant) {
        thumbnailImage.image = UIImage(named: restaurant.image)
        nameLabel.text = restaurant.name
        cuisineLabel.text = restaurant.cuisine
    }
    
}
