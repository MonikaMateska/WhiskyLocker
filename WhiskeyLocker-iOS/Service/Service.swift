import Foundation
import SwiftUI

class Storage {
    
    static let sharedInstance: Storage = Storage()
    
    @AppStorage("userToken") var userToken: Int = -1
}

protocol ServiceProtocol {
    
    func loginUser(username: String, password: String) async
    
    func registerUser(email: String, firstName: String, lastName: String, password: String, username: String) async
    
    func getLocker(byId id: Int) async -> LockerResponse?
    
    func myLockers(ownerId: Int) async -> [MyLockerItem]
    
    func getCabinets() async -> [CabinetResponse]
    
    func claimLocker(withId id: Int) async
    
    func releaseLocker(withId id: Int) async
    
    func lockLocker(withId id: Int) async
    
    func unlockLocker(withId id: Int) async
    
    func shareLocker(withId id: Int, employeeId: Int) async

    func registerDeviceToken() async
    
    func employeeDetails() async -> EmployeeResponse?
    
    func getEmployees(searchText search: String) async -> [Employee]
}

extension URLRequest {
    mutating func setupUrlRequest() {
        addValue(String(Storage.sharedInstance.userToken), forHTTPHeaderField: "x-locker-token")
        setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
    }
}

class MockService: ServiceProtocol {
    func shareLocker(withId id: Int, employeeId: Int) async {
        
    }
    
    func releaseLocker(withId id: Int) async {
        
    }
    
    func loginUser(username: String, password: String) async {
        
    }
    
    func registerUser(email: String, firstName: String, lastName: String, password: String, username: String) async {
        
    }
    
    func getLocker(byId id: Int) async -> LockerResponse? {
        return LockerResponse(id: 1,
                              code: 1,
                              status: .unlocked,
                              shares: [Share(id: 2), Share(id: 3)],
                              owner: 1)
    }
    
    func myLockers(ownerId: Int) async -> [MyLockerItem] {
        return []
    }
    
    func getCabinets() async -> [CabinetResponse] {
        [CabinetResponse(id: 1, name: "alu", location: "Skopje", description: ""),
         CabinetResponse(id: 2, name: "club", location: "Skopje", description: ""),
         CabinetResponse(id: 3, name: "city-tower", location: "Skopje", description: "")]
    }
    
    func employeeDetails() async -> EmployeeResponse? {
        return EmployeeResponse(id: 1,
                                username: "mms",
                                firstName: "Monika",
                                lastName: "Mateska")
    }
    
    func getEmployees(searchText search: String) async -> [Employee] {
        return []
    }
    
    func claimLocker(withId id: Int) async { }
    
    func lockLocker(withId id: Int) async { }
    
    func unlockLocker(withId id: Int) async { }
    
    func registerDeviceToken() async { }
}
