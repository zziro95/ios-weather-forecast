import Foundation

struct Weather: Decodable {
    let stateID: Int
    let main: String
    let description: String
    let iconID: String
    
    enum CodingKeys: String, CodingKey {
        case stateID = "id"
        case main, description
        case iconID = "icon"
    }
}
