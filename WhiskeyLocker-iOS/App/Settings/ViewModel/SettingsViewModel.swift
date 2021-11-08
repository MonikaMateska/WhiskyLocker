import Foundation

class SettingsViewModel<C:RootCoordinator>: ViewModel<C>, ObservableObject {
    
    @Published var user: EmployeeResponse? = nil
    
    private var apiService: MockService
    
    init(coordinator: C,
        apiService: MockService) {
        self.apiService = apiService
        super.init(coordinator: coordinator)
        loadEmployeeData()
    }
    
    func logoutTapped() {
        Storage.sharedInstance.userToken = -1
        coordinator?.parent?.showNextFeature(nextState: .login)
    }
    
    private func loadEmployeeData() {
        Task {
            let employee = await apiService.employeeDetails()
            DispatchQueue.main.async { [weak self] in
                self?.user = employee
            }
        }
    }
    
}
