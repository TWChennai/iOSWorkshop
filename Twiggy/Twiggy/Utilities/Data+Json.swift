import Foundation

extension Data {    
    var toJsonArray: [[String : Any]] {
        var json: [[String: Any]] = []
        do {
            json = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [[String : Any]]
        } catch {
            print("invalid data")
        }
        
        return json
    }
}
