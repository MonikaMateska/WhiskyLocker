import SwiftUI

/// Protocol definition for the base coordinator types.
protocol BaseCoordinator: AssociatedObject {
    /// Stops the coordinator.
    func stop()
}

extension BaseCoordinator {
    fileprivate(set) var identifier: UUID {
        get {
            guard let identifier: UUID = associatedObject(for: &identifierKey) else {
                self.identifier = UUID()
                return self.identifier
            }
            return identifier
        }
        set { setAssociatedObject(newValue, for: &identifierKey) }
    }
    
    fileprivate(set) var children: [UUID: BaseCoordinator] {
        get {
            guard let children: [UUID: BaseCoordinator] = associatedObject(for: &childrenKey) else {
                self.children = [UUID: BaseCoordinator]()
                return self.children
            }
            return children
        }
        set {
            setAssociatedObject(newValue, for: &childrenKey)
        }
    }
    
    fileprivate func store<T: Coordinator>(child coordinator: T) {
        children[coordinator.identifier] = coordinator
    }
    
    fileprivate func free<T: Coordinator>(child coordinator: T) {
        children.removeValue(forKey: coordinator.identifier)
    }
}

/// Main coordinator is a parent coordinator that can coordinate between features.
protocol MainCoordinator: Coordinator {
    /// Shows the next feature.
    func showNextFeature(nextState: AppState?)
}

extension MainCoordinator {
    
    func showNextFeature(nextState: AppState?) { }
    
}

/// Protocol defining methods for the coordinators used for navigation.
protocol Coordinator: BaseCoordinator {
    associatedtype U: View
    associatedtype P: MainCoordinator
    
    /// Starts the coordination.
    func start() -> U
    
    /// Stops the coordination.
    func shouldStop()
    
    /// Called when the coordinator and its feature should be closed.
    func closeFeature()
}

extension Coordinator {
    private(set) weak var parent: P? {
        get { associatedObject(for: &parentKey) }
        set { setAssociatedObject(newValue, for: &parentKey, policy: .weak) }
    }
    
    func coordinate<T: Coordinator>(to coordinator: T) -> some View {
        store(child: coordinator)
        coordinator.parent = self as? T.P
        return coordinator.start()
    }
    
    func stop() {
        children.removeAll()
        parent?.free(child: self)
    }
    
    func shouldStop() {
        stop()
    }
    
    func closeFeature() {
        parent?.showNextFeature(nextState: nil)
    }

}

private var identifierKey: UInt8 = 1
private var childrenKey: UInt8 = 2
private var parentKey: UInt8 = 3
