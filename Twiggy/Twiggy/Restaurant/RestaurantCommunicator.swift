import Foundation

class RestaurantCommunicator {

    class func getRestaurants(completion:@escaping ([Restaurant], _ error: Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: NSURL(string: "https://api.mlab.com/api/1/databases/twiggy/collections/restaurants?apiKey=lFqcDbkLHMlgtWev1Q05iLMbwVYdWcm5")! as URL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([], error)
                return
            }
            
            if let jsonArray = data?.toJsonArray {
                var restaurants: [Restaurant] = []
                for json in jsonArray {
                    if let restaurant = Restaurant(json) {
                        restaurants.append(restaurant)
                    }
                }
                
                completion(restaurants, nil)
            } else {
                completion([], error)
            }
        }
        
        dataTask.resume()
    }
}
