import UIKit

class RestaurantMenuItemsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let restaurantMenuItemCellIdentifier = "RestaurantMenuItemCellIdentifier"
    private let menuCellHeight: CGFloat = 80.0
    
    private let viewModel = RestaurantMenuItemsViewModel()
    
    var restaurantName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = restaurantName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RestaurantMenuItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: restaurantMenuItemCellIdentifier) as! RestaurantMenuItemTableViewCell
        let menuItem = viewModel.menuItems[indexPath.row]
        cell.updateMenuItem(menuItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuItems.count
    }
}

extension RestaurantMenuItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return menuCellHeight
    }
}

extension RestaurantMenuItemsViewController: RestaurantMenuItemTableViewCellDelegate {
    
    func addToCart() {
        
    }
}
