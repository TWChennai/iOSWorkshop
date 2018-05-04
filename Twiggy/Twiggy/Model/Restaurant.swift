
struct Restaurant {
    let name: String
    let cuisine: String
    let image: String
    
    init?(_ json: [String: Any]) {
        guard let name = json["name"] as? String,
            let cuisine = json["cuisine"] as? String,
            let image = json["image"] as? String else {
                
            return nil
        }
        
        self.name = name
        self.cuisine = cuisine
        self.image = image
    }
}
