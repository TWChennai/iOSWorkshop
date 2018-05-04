import Foundation

class RestaurantCommunicator {

    class func getRestaurants(completion:@escaping ([Restaurant], _ error: Error?) -> Void) {
        
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "7794bb6a-63d5-b583-6cd9-106c6e5f3bce"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.mlab.com/api/1/databases/twiggy/collections/restaurants?apiKey=lFqcDbkLHMlgtWev1Q05iLMbwVYdWcm5")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
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
        })
        
        dataTask.resume()
    }
}
