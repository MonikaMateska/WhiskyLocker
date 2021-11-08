import SwiftUI
import Combine

final class AppCoordinator: MainCoordinator {
    
    typealias P = AppCoordinator
    
    private var appState: AppState
    private var cancelables = Set<AnyCancellable>()
    private let appContainer: AppDependencyContainer
    
    init(appContainer: AppDependencyContainer) {
        self.appContainer = appContainer
        self.appState = appContainer.appService.appState
        
        self.appContainer.appService.$appState.sink { [weak self] (state) in
            if state != self?.appState {
                self?.handleStateChange(appState: state)
            }
        }
        .store(in: &cancelables)
    }
    
    func showNextFeature(nextState: AppState?) {
        if let nextState = nextState {
            self.appContainer.appService.update(appState: nextState)
            return
        }
        
        if self.appState == .login {
            self.appContainer.appService.update(appState: .registeredUser)
            return
        }
        
        if self.appState == .registeredUser {
            self.appContainer.appService.update(appState: .login)
            return
        }
    }
    
    private func handleStateChange(appState: AppState) {
        self.stop()
        self.appState = appState
        switch appState {
        case .login:
            let coordinator = appContainer.makeLoginCoordinator()
            _ = coordinate(to: coordinator)
        default:
            let coordinator = appContainer.makeRootCoordinator()
            _ = coordinate(to: coordinator)
        }
    }
    
    @discardableResult
    func start() -> some View {
        handleStateChange(appState: appState)
        return EmptyView()
    }
    
    deinit {
        cancelables.removeAll()
    }
    
}
