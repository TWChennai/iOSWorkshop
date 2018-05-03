import UIKit

class RestaurantListViewController: UIViewController {
    
    private let restaurantListToFoodMenuSegueIdentifier = "RestaurantListToFoodMenuSegueIdentifier"
    private let restaurantViewCellIdentifier = "RestaurantViewCellIdentifier"
    
    @IBOutlet private weak var restaurantTableView: UITableView!
    
    let viewModel: RestaurantListViewModel = RestaurantListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = NSLocalizedString("RestaurantListTitle", comment: "RestaurantListTitle")
        configureTableView()
    }
    
    func configureTableView() {
        restaurantTableView.tableFooterView = UIView(frame: CGRect.zero)
        restaurantTableView.register(UINib.init(nibName: "RestaurantViewCell", bundle: nil), forCellReuseIdentifier: restaurantViewCellIdentifier)
        restaurantTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == restaurantListToFoodMenuSegueIdentifier, let vc = segue.destination as? RestaurantMenuItemsViewController {
            if let restaurantName = sender as? String {
                vc.restaurantName = restaurantName
            }
        }
    }
}

extension RestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: restaurantViewCellIdentifier, for: indexPath)
        guard let restaurantViewCell = cell as? RestaurantViewCell else {
            return cell
        }
        restaurantViewCell.config(restaurant: viewModel.getRestaurantAtIndex(indexPath.row))
        return restaurantViewCell
    }
}

extension RestaurantListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = viewModel.restaurantList[indexPath.row]
        performSegue(withIdentifier: restaurantListToFoodMenuSegueIdentifier, sender: restaurant.name)
    }
}
