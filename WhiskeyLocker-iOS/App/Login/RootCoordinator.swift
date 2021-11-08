import UIKit
import SwiftUI

/// Protocol defining methods for the root feature coordination.
protocol RootCoordinator: Coordinator {
    func showClaimNewLockerView() -> ClaimNewLockerView
    func showDetailsView(locker: LockerResponse, myLockerItem: MyLockerItem?) -> DetailsView
    func showSettingsView() -> SettingsView
    func showShareView(lockerId: Int, isPresented: Binding<Bool>) -> ShareView
}

/// Implementation of the `RootCoordinator` protocol.
final class RootCoordinatorLogic: RootCoordinator {
    typealias P = AppCoordinator
    
    private let rootContainer: RootDependencyContainer
    private weak var window: UIWindow?
    
    init(window: UIWindow?,
         rootContainer: RootDependencyContainer) {
        self.window = window
        self.rootContainer = rootContainer
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
    
    func showClaimNewLockerView() -> ClaimNewLockerView {
        let viewModel = rootContainer.makeClaimNewLockerViewModel(coordinator: self)
        let view = ClaimNewLockerView(viewModel: viewModel)
        
        return view
    }
    
    func showDetailsView(locker: LockerResponse, myLockerItem: MyLockerItem?) -> DetailsView {
        let viewModel = rootContainer.makeDetailsViewModel(coordinator: self,
                                                           locker: locker, myLockerItem: myLockerItem)
        let view = DetailsView(viewModel: viewModel)
        
        return view
    }
    
    func showShareView(lockerId: Int, isPresented: Binding<Bool>) -> ShareView {
        let viewModel = rootContainer.makeShareViewModel(coordinator: self, lockerId: lockerId, isPresented: isPresented)
        return ShareView(viewModel: viewModel)
    }
    
    func showSettingsView() -> SettingsView {
        let viewModel = rootContainer.makeSettingsViewModel(coordinator: self)
        let view = SettingsView(viewModel: viewModel)
        
        return view
    }
    
    private func setupHostingController() {
        let view = self.rootContainer.makeRootView(coordinator: self)
        let navigation = NavigationView { view }
            .navigationViewStyle(StackNavigationViewStyle())
        let hosting = UIHostingController(rootView: navigation)
        window?.rootViewController = hosting
        window?.makeKeyAndVisible()
    }
}
