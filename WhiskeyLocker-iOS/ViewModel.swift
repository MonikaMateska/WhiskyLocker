import SwiftUI
import Combine

/// Base class for view models.
/// All other view models should subclass it.
class ViewModel<C: Coordinator> {
    
    private(set) weak var coordinator: C?
    
    var cancelables = Set<AnyCancellable>()
    
    init(coordinator: C) {
        self.coordinator = coordinator
    }
    
    deinit {
        cancelables.removeAll()
    }
}

