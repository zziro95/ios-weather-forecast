import Foundation

struct Clouds: Decodable {
    let allOver: Int
    
    enum CodingKeys: String, CodingKey {
        case allOver = "all"
    }
}
