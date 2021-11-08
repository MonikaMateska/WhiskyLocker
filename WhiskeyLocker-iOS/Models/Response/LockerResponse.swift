import Foundation

enum LockStatus: String, Codable {
    case locked = "locked"
    case unlocked = "unlocked"
}

struct LockerResponse: Codable, Identifiable {
    let id: Int
    let code: Int
    let status: LockStatus
    let shares: [Share]?
    let owner: Int?
}

struct MyLockerItem: Codable {
    let locker: LockerResponse
    let cabinet: Cabinet
    let owner: Owner
    let ownership: String
}

struct Share: Codable {
    let id: Int
}

struct Owner: Codable {
    let id: Int
    let username, email, firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case id, username, email
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct EmployeeResponse: Codable, Identifiable {
    let id: Int
    let username, firstName, lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id, username
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
