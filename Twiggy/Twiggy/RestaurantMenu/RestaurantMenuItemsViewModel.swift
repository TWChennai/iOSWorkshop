
struct RestaurantMenuItemsViewModel {
    var menuItems = [RestaurantMenuItem]()
    
    init() {
        mockFoodMenuList()
    }
    
    private mutating func mockFoodMenuList() {
        menuItems.append(RestaurantMenuItem(name: "Veggie Supreme - 9 inch", price: 120.0))
        menuItems.append(RestaurantMenuItem(name: "PeriPeri Chicken - 9 inch", price: 135.0))
        menuItems.append(RestaurantMenuItem(name: "Paneer Delight - 13 inch", price: 125.0))
    }
}
