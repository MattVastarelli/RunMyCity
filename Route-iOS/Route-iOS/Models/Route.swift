import Foundation

// route types
enum RouteTerain: String {
    case trail = "Trail"
    case road = "Road"
    case path = "Path"
}
// route type
enum ActivityType: String {
    case run = "Run"
    case bike = "Bike"
    case walk = "Walk"
}
// route attributes
enum RouteAttributes: String {
    case potHoles = "Pot Holes"
    case groomed = "Groomed Trail"
    case crosswalk = "Crosswalks Available"
    case wellLit = "Good Lighting"
    case poorlyLit = "Poor Lighting"
    case noLineOfSight = "Poor Lines of Sight"
    case goodLineOfSight = "Good Lines of Sight"
    case blindCorner = "Blind Corners"
}
// traffic speed
enum RouteTrafficSpeed: String {
    case slow = "Slow"
    case fair = "Fair"
    case fast = "Fast"
}
// location type
enum RouteLocationType: String {
    case city = "Urban"
    case rural = "Rural"
    case suburban = "Suburban"
    case park = "Park"
}

// route class
class Route: NSObject{
    private var terain: String
    private var locationType: String
    private var trafficSpeed: String
    private var activityType: String
    private var attributes: [String]
    //---------------------------------------------------------------------------------
    init(terain: String, locationType: String, trafficSpeed: String, activityType: String, attributes: [String]) {
        self.terain = terain
        self.locationType = locationType
        self.trafficSpeed = trafficSpeed
        self.activityType = activityType
        self.attributes = attributes
    }
    //---------------------------------------------------------------------------------
    // route getters
    func getTerain() -> String {
        return self.terain
    }
    
    func getLocationType() -> String {
        return self.locationType
    }
    
    func getTrafficSpeed() -> String {
        return self.trafficSpeed
    }
    
    func getActivityType() -> String {
        return self.activityType
    }
    
    func getAttributes() -> [String] {
        return self.attributes
    }
    // route setters
    func setTerain(terain: String) {
        self.terain = terain
    }
    
    func setLocationType(loc: String) {
        self.locationType = loc
    }
    
    func setTrafficSpeed(speed: String) {
        self.trafficSpeed = speed
    }
    
    func setActivityType(type: String) {
        self.activityType = type
    }
    
    func setAttributes(attr: [String]) {
        self.attributes = attr
    }
    
    func getRouteCollection() -> [String: Any] {
        let rc = [
            "terain": self.terain,
            "location": self.locationType,
            "traffic speed": self.trafficSpeed,
            "activity type": self.activityType,
            "attributes": self.attributes
            ] as [String : Any]
        
        return rc
    }
}
