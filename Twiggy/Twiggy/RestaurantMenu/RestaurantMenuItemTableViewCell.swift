//
//  RestaurantMenuTableViewCell.swift
//  Twiggy
//
//  Created by Ponnalagu Sukumar Mennan on 03/05/18.
//  Copyright © 2018 Sushant Kumar. All rights reserved.
//

import UIKit

class RestaurantMenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    private(set) var menuItem: RestaurantMenuItem?
    
    weak var delegate: RestaurantMenuItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        delegate?.addToCart()
    }
    
    func updateMenuItem(_ menuItem: RestaurantMenuItem) {
        name.text = menuItem.name
        price.text = "\(menuItem.price.description) INR"
    }
}

protocol RestaurantMenuItemTableViewCellDelegate: class {
    func addToCart()
}
