import UIKit

class RestaurantViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(restaurant: Restaurant) {
        
        let url = URL(string:restaurant.image)
        if let data = try? Data(contentsOf: url!){
            self.thumbnailImage.image = UIImage(data: data)
        }
        
        nameLabel.text = restaurant.name
        cuisineLabel.text = restaurant.cuisine
    }
}
