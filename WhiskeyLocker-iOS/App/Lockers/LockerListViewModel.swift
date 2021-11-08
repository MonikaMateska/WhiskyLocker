import Foundation

enum LockerFilter {
    case myLockers
    case sharedLockers
}

class LockerListViewModel<C:RootCoordinator>: ViewModel<C>, ObservableObject {
    @Published var lockerFilter: LockerFilter = .myLockers
    @Published var myLockers = [LockerResponse]()
    @Published var sharedLockers = [LockerResponse]()
    @Published var claimNewLockerShown = false
    
    private var apiService: ServiceProtocol
    private var userId = Storage.sharedInstance.userToken
    private var myLockerItem: MyLockerItem?

    init(coordinator: C, apiService: ServiceProtocol) {
        self.apiService = apiService
        super.init(coordinator: coordinator)
        getLockers()
    }
    
    func getLockers() {
        Task {
            let lockersResponse = await apiService.myLockers(ownerId: userId)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.myLockers = lockersResponse.filter { $0.owner.id == self.userId }.map { $0.locker }
                self.sharedLockers = lockersResponse.filter { $0.owner.id != self.userId }.map { $0.locker }
                self.myLockerItem = lockersResponse.first(where: { $0.owner.id == self.userId })
            }
        }
    }
    
    func showDetailsView(locker: LockerResponse) -> DetailsView? {
        return coordinator?.showDetailsView(locker: locker, myLockerItem: myLockerItem)
    }
    
    func showClaimNewLocker() -> ClaimNewLockerView? {
        return coordinator?.showClaimNewLockerView()
    }
    
    func showSettingsView() -> SettingsView? {
        return coordinator?.showSettingsView()
    }
}
