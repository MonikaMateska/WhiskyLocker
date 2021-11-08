import SwiftUI

enum LoginState {
    case login
}

/// Protocol defining methods for the login feature coordination.
protocol LoginCoordinator: Coordinator {}

/// Implementation of the `LoginCoordinator` protocol.
final class LoginCoordinatorLogic: LoginCoordinator {
    
    typealias P = AppCoordinator
    private let loginContainer: LoginDependencyContainer
    private weak var window: UIWindow?
    
    init(window: UIWindow?,
         loginContainer: LoginDependencyContainer) {
        self.window = window
        self.loginContainer = loginContainer
    }
    
    @discardableResult
    func start() -> some View {
        if Thread.isMainThread {
            setupHostingController()
        } else {
            DispatchQueue.main.sync { [unowned self] in
                self.setupHostingController()
            }
        }
        
        return EmptyView()
    }
    
    private func setupHostingController() {
        let view = self.loginContainer.makeLoginView(coordinator: self)
        let navigation = NavigationView { view }
            .navigationViewStyle(StackNavigationViewStyle())
        let hosting = UIHostingController(rootView: navigation)
        window?.rootViewController = hosting
        window?.makeKeyAndVisible()
    }
    
}

