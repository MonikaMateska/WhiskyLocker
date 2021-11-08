import Foundation

struct Locker: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    let name: String
    let owner: Int
    let cabinetId: Int
}
