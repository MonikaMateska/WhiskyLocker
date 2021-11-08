import Combine
import Foundation

let loginRequired = "LoginRequired"

/// Defines the possible states where the app can be.
enum AppState: String {
    /// Login screen is currently shown.
    case login
    /// App with registered user is currently shown.
    case registeredUser
}

/// Class that manages the app state.
class AppService {
        
    /// The current app state.
    @Published private(set) var appState: AppState
    
    init(initialState: AppState) {
        self.appState = initialState
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleRequiredLogin),
                                               name: NSNotification.Name(loginRequired),
                                               object: nil)
    }
    
    /// Updates the app state.
    ///
    /// - Parameters:
    ///   - appState, the new appState.
    func update(appState: AppState) {
        self.appState = appState
    }
    
    // MARK: - private
    
    @objc
    private func handleRequiredLogin() {
        self.appState = .login
    }
    
}
