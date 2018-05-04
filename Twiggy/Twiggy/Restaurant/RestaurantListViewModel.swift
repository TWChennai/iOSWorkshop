import Foundation

class RestaurantListViewModel {
    
    var restaurantList: [Restaurant] = []
    
    func fetchRestaurants(completion:@escaping () -> Void) {
        RestaurantCommunicator.getRestaurants { (restaurants, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.restaurantList = restaurants
            completion()
        }
    }
    
    func getRestaurantAtIndex(_ index: Int) -> Restaurant {
        return restaurantList[index]
    }
    
    /*private func mockRestaurantList() {
        restaurantList.append(Restaurant(name: "Dominos", cuisine: "Fast food", image: "dominos"))
        restaurantList.append(Restaurant(name: "Mcdonalds", cuisine: "Fast food", image: "mcdonalds"))
        restaurantList.append(Restaurant(name: "Paradise", cuisine: "Biryani", image: "paradise"))
        restaurantList.append(Restaurant(name: "The Red Box", cuisine: "Chinese", image: "red_box"))
    }*/
}
