import Foundation
import UIKit

/// Dependency container for the app components.
class AppDependencyContainer {
    
    private struct Constants {
        static let firstStart = "firstStart"
    }
    
    private(set) var appService: AppService!
    private lazy var apiService = MockService()
    private weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        var initialState: AppState = .login
        
        if Storage.sharedInstance.userToken != -1 {
            initialState = .registeredUser
        }
        
        appService = AppService(initialState: initialState)
    }
    
    // MARK: - Coordinators
    
    /// Creates and returns an AppCoordinator.
    /// - Returns: `AppCoordinator`
    func makeAppCoordinator() -> AppCoordinator {
        return AppCoordinator(appContainer: self)
    }
    
    /// Creates and returns an LoginCoordinator.
    /// - Returns: `LoginCoordinator`
    func makeLoginCoordinator() -> some LoginCoordinator {
        return LoginCoordinatorLogic(window: window, loginContainer: makeLoginContainer())
    }
    
    func makeRootCoordinator() -> some RootCoordinator {
        return RootCoordinatorLogic(window: window, rootContainer: makeRootContainer())
    }
    
    // MARK:  - Dependencies
    
    
    /// Creates and returns login dependency container.
    /// - Returns: `LoginDependencyContainer`
    private func makeLoginContainer() -> LoginDependencyContainer {
        return LoginDependencyContainer(appService: appService,
                                        apiService: apiService)
    }
    
    /// Creates and returns root dependency container
    /// - Returns: `RootDependencyContainer`
    private func makeRootContainer() -> RootDependencyContainer {
        return RootDependencyContainer(appService: appService,
                                       apiService: apiService)
    }
    
}
