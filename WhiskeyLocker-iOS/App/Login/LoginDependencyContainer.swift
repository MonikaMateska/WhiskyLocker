import Foundation
import SwiftUI

/// Container for the login dependencies.
class LoginDependencyContainer {
    
    typealias C = LoginCoordinatorLogic
    
    private let appService: AppService
    private let apiService: MockService
    
    init(appService: AppService,
         apiService: MockService) {
        self.appService = appService
        self.apiService = apiService
    }
    
    func makeLoginView(coordinator: C) -> LoginView {
        let viewModel = LoginViewModel(coordinator: coordinator,
                                       appService: appService,
                                       apiService: apiService)
        let view = LoginView(viewModel: viewModel)
        return view
    }
    
}
