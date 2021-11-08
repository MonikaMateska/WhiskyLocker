import Foundation
import SwiftUI

class DetailsViewModel<R:RootCoordinatorLogic>: ViewModel<R>, ObservableObject {
    
    let locker: LockerResponse
    var myLockerItem: MyLockerItem?
    private let apiService: ServiceProtocol
    
    var ownerUsername: String?
    
    @Published var lockerStatus: LockStatus?
    @Published var showShareScreen: Bool = false
    
    init(coordinator: R,
         apiService: ServiceProtocol,
         locker: LockerResponse,
         myLockerItem: MyLockerItem?) {
        self.apiService = apiService
        self.locker = locker
        self.myLockerItem = myLockerItem
        self.ownerUsername = myLockerItem?.owner.username
        self.lockerStatus = locker.status
        super.init(coordinator: coordinator)
    }
    
    func unlockLocker() {
        Task {
            await apiService.unlockLocker(withId: locker.id)
            DispatchQueue.main.async { [weak self] in
                self?.lockerStatus = .unlocked
            }
        }
    }
    
    func lockLocker() {
        Task {
            await apiService.lockLocker(withId: locker.id)
            DispatchQueue.main.async { [weak self] in
                self?.lockerStatus = .locked
            }
        }
    }
    
    func releaseLocker() {
        Task {
            await apiService.releaseLocker(withId: locker.id)
        }
    }
    
    func presentShareView(isPresented: Binding<Bool>) -> ShareView {
        return coordinator!.showShareView(lockerId: locker.id, isPresented: isPresented)
    }
}
