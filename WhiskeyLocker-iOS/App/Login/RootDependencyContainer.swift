import SwiftUI

/// Container for the root dependencies.
class RootDependencyContainer {
    typealias C = RootCoordinatorLogic
    private let appService: AppService
    private let apiService: MockService
    
    init(appService: AppService,
         apiService: MockService) {
        self.appService = appService
        self.apiService = apiService
    }
    
    func makeRootView(coordinator: C) -> LockerListView {
        let viewModel = LockerListViewModel(coordinator: coordinator, apiService: apiService)
        return LockerListView(viewModel: viewModel)
    }
    
    func makeClaimNewLockerViewModel(coordinator: C) -> ClaimNewLockerViewModel<RootCoordinatorLogic> {
        let viewModel = ClaimNewLockerViewModel<RootCoordinatorLogic>(coordinator: coordinator,
                                                                      apiService: apiService)
        return viewModel
    }
    
    func makeDetailsViewModel(coordinator: C,
                              locker: LockerResponse,
                              myLockerItem: MyLockerItem?) -> DetailsViewModel<RootCoordinatorLogic> {
        let viewModel = DetailsViewModel(coordinator: coordinator,
                                         apiService: apiService,
                                         locker: locker,
                                         myLockerItem: myLockerItem)
        return viewModel
    }
    
    func makeShareViewModel(coordinator: C, lockerId: Int, isPresented: Binding<Bool>) -> ShareViewModel<RootCoordinatorLogic> {
        let viewModel = ShareViewModel(coordinator: coordinator, apiService: apiService, lockerId: lockerId, isPresented: isPresented)
        return viewModel
    }
    
    func makeSettingsViewModel(coordinator: C) -> SettingsViewModel<RootCoordinatorLogic> {
        let viewModel = SettingsViewModel(coordinator: coordinator,
                                          apiService: apiService)
        return viewModel
    }
}
