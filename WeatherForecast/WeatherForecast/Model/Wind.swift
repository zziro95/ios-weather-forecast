import Foundation

struct Wind: Decodable {
    let speed: Double
    let degree: Int
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}
