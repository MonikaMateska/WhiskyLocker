import Foundation

class LoginViewModel<C:LoginCoordinator>: ViewModel<C>, ObservableObject {
    /// Registration input data
    @Published var email = ""
    @Published var firstName = ""
    @Published var lastName = ""
    
    /// Loding input data
    @Published var username = ""
    @Published var password = ""
    
    private let apiService: ServiceProtocol
    private let appService: AppService
    
    init(coordinator: C,
         appService: AppService,
         apiService: ServiceProtocol) {
        self.apiService = apiService
        self.appService = appService
        super.init(coordinator: coordinator)
    }
    
    func loginPressed() {
        Task {
            await apiService.loginUser(username: username, password: password)
            await MockService().registerDeviceToken()
            appService.update(appState: .registeredUser)
            coordinator?.closeFeature()
        }
    }
    
    func registerPressed() {
        Task {
            await apiService.registerUser(email: email,
                                          firstName: firstName,
                                          lastName: lastName,
                                          password: password,
                                          username: username)
            appService.update(appState: .registeredUser)
            coordinator?.closeFeature()
        }
    }
}
