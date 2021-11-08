import Foundation

struct Employee: Codable, Identifiable, Hashable {
    let id: Int
    let username: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id, username
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
