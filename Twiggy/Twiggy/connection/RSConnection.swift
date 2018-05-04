import Foundation

let RSBaseUrl: String = "www.production-dev.com" //This is just a name sake url string - should be changed

let RSStagingBaseUrl: String = "www.test-dev.com" //This is just a name sake url string - should be changed

typealias responseCompletion = (_ response: [String : Any]?, _ status: Bool?) -> Void

public struct RSConnection {
    
    //MARK: GET Calls
    static func get(_ path: String, query:[URLQueryItem]?, completion: @escaping responseCompletion) -> URLSessionDataTask{
        let getUrl: URLComponents! = RSConnection.buildGetUrl(path, parameters: query)
        let request = NSMutableURLRequest(url: getUrl.url!)
        request.httpMethod = "GET"
        
        return RSConnection.sendRequest(request, completion: completion)
    }
    
    static func getWithDevBase(_ path: String, query: [URLQueryItem]?, completion: @escaping responseCompletion) -> URLSessionTask {
        var getUrl = URLComponents(string: RSStagingBaseUrl)!
        getUrl.path = (getUrl.path) + path
        
        let request = NSMutableURLRequest(url: getUrl.url!)
        request.httpMethod = "GET"
        
        return RSConnection.sendRequest(request, completion: completion)
    }
    
    //MARK: POST Calls
    static func post(_ path: String, query: [String : AnyObject], completion:@escaping responseCompletion) -> URLSessionDataTask {
        let getUrl = RSConnection.connectionUrlComponent()
        let request = NSMutableURLRequest(url: getUrl.url!)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: query, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            #if DEBUG
                debugPrint("%@ body is empty", getUrl.url?.absoluteString as Any)
            #endif
        }
        
        return RSConnection.sendRequest(request, completion: completion)
    }
    
    //MARK: Path Builder
    static func buildGetUrl(_ path: String, parameters: [URLQueryItem]?) -> URLComponents {
        var urlComponents = RSConnection.connectionUrlComponent()
        
        if  !urlComponents.path.isEmpty {
            urlComponents.path = urlComponents.path + path
        } else {
            urlComponents.path = path
        }
        
        if let _ = parameters {
            urlComponents.queryItems = parameters
        }
        
        return urlComponents
    }
    
    //MARK: URL Component Builder
    static func connectionUrlComponent() -> URLComponents {
        let urlComponents = URLComponents(string: RSBaseUrl)
        
        return urlComponents!
    }
    
    //MARK: Request Handler
    static func sendRequest(_ request:NSMutableURLRequest, completion:@escaping responseCompletion) -> URLSessionDataTask {
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (response, urlResponse, error) in
            
            var success = false
            var responseDictionary: [String : Any]! = [:]
            
            let httpResponse = urlResponse as? HTTPURLResponse
            //Replace with switch if more error codes have to be handled
            if httpResponse?.statusCode == 200 || httpResponse?.statusCode == 201 {
                if let _ = response {
                    do {
                        responseDictionary = try JSONSerialization.jsonObject(with: response!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String : Any]
                    } catch {
                        #if DEBUG
                            debugPrint("%@ has returned invalid data", request.url?.absoluteString as Any)
                        #endif
                    }
                    
                    if let _ = responseDictionary, responseDictionary.count > 0 {
                        success = true
                    }
                }
            } else {
                success = false
                
                #if DEBUG
                    debugPrint("%@ - STATUS %@", request.url?.absoluteString as Any, error?.localizedDescription as Any)
                #endif
            }
            completion(responseDictionary, success)
        }
        
        task.resume()
        
        return task
    }
    
    //MARK: Query Component Builder
    static func queryParameters(_ parameters: [String : String]) -> [URLQueryItem] {
        var queryParameters = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            queryParameters.append(queryItem)
        }
        
        return queryParameters
    }
    
}
