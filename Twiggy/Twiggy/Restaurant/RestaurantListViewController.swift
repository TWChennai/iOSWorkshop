import UIKit

class RestaurantListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var restaurantTableView: UITableView!
    
    let viewModel: RestaurantListViewModel = RestaurantListViewModel()
    let RestaurantViewCellIdentifier = "RestaurantViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("RestaurantListTitle", comment: "RestaurantListTitle")
        
        restaurantTableView.tableFooterView = UIView(frame: CGRect.zero)
        restaurantTableView.register(UINib.init(nibName: "RestaurantViewCell", bundle: nil), forCellReuseIdentifier: RestaurantViewCellIdentifier)
        restaurantTableView.rowHeight = UITableViewAutomaticDimension
        viewModel.mockRestaurantList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantViewCellIdentifier, for: indexPath)
        guard let restaurantViewCell = cell as? RestaurantViewCell else {
            return cell
        }
        restaurantViewCell.config(restaurant: viewModel.getRestaurantAtIndex(indexPath.row))
        return restaurantViewCell
    }
    
}
