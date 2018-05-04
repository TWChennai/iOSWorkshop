//
//  RestaurantMenuTableViewCell.swift
//  Twiggy
//
//  Created by Ponnalagu Sukumar Mennan on 03/05/18.
//  Copyright © 2018 Sushant Kumar. All rights reserved.
//

import UIKit

class RestaurantMenuItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var picture: UIImageView!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var price: UILabel!
    
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
        sender.isSelected = !sender.isSelected
        delegate?.addToCart()
    }
    
    func updateMenuItem(_ menuItem: RestaurantMenuItem) {
        name.text = menuItem.name
        price.text = "\(menuItem.price.description) Rs"
        button.isSelected = false //TODO:: fetch state from DB and set state
    }
}

protocol RestaurantMenuItemTableViewCellDelegate: class {
    func addToCart()
}
