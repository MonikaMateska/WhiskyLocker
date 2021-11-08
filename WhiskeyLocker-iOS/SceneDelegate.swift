import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appDependencyContainer: AppDependencyContainer!
    var appCoordinator: AppCoordinator!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let appWindow = UIWindow(windowScene: windowScene)
            appDependencyContainer = AppDependencyContainer(window: appWindow)
            appCoordinator = appDependencyContainer.makeAppCoordinator()
            appCoordinator.start()
            self.window = appWindow
            
            setupPushNotifications()
        }
    }
    
    func setupPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
        
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
    }
}
