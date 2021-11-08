import Foundation
import SwiftUI

class ShareViewModel<R:RootCoordinatorLogic>: ViewModel<R>, ObservableObject {
    
    @Published var employees = [Employee]() {
        didSet {
            shouldShowShareButton = !employees.isEmpty
        }
    }
    @Published var searchText = "" {
        didSet {
            getEmployees(for: searchText.lowercased())
        }
    }
    @Published var selectedEmployees: [Int] = []
    @Binding var isPresented: Bool
    @Published var shouldShowShareButton: Bool = false
    let lockerId: Int
    private let apiService: MockService
    
    init(coordinator: R, apiService: MockService, lockerId: Int, isPresented: Binding<Bool>) {
        self.apiService = apiService
        self.lockerId = lockerId
        self._isPresented = isPresented
        super.init(coordinator: coordinator)
        getEmployees(for: searchText.lowercased())
    }
    
    func getEmployees(for searchText: String)  {
        Task {
           let employees = await apiService.getEmployees(searchText: searchText)
            DispatchQueue.main.async {
                self.employees = employees.filter { $0.id != Storage.sharedInstance.userToken }
            }
        }
    }
    
    func employeeTapped(withId id: Int) {
        if let index = selectedEmployees.firstIndex(of: id) {
            selectedEmployees.remove(at: index)
        } else {
            selectedEmployees.append(id)
        }
    }
    
    func isEmployeeSelected(id: Int) -> Bool {
        selectedEmployees.contains(id)
    }
    
    func shareWithSelectedFriends() {
        for id in selectedEmployees {
            Task {
                await MockService().shareLocker(withId: lockerId, employeeId: id)
            }
        }
        isPresented = false
    }
}
