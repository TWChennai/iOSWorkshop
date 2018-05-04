import Foundation
import Alamofire

class RestaurantCommunicator {

    
    class func getRestaurants(completion:@escaping ([Restaurant], _ error: Error?) -> Void) {
        Alamofire.request(NSURL(string: "https://api.mlab.com/api/1/databases/twiggy/collections/restaurants?apiKey=lFqcDbkLHMlgtWev1Q05iLMbwVYdWcm5")! as URL,
                          method: .get)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion([], nil)
                    return
                }
                
                if let jsonArray = response.result.value as? [[String: Any]] {
                    var restaurants: [Restaurant] = []
                    for json in jsonArray {
                        if let restaurant = Restaurant(json) {
                            restaurants.append(restaurant)
                        }
                    }
                    completion(restaurants, nil)
                } else {
                    completion([], NSError(domain: "domain", code: 12, userInfo: nil))
                }
        }
    
    }
    
    class func getRestaurantsInTraditionalWay(completion:@escaping ([Restaurant], _ error: Error?) -> Void) {
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
