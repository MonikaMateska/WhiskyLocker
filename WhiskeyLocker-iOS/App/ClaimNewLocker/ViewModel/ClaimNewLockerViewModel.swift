import SwiftUI

enum ClaimLockerSteps: String {
    case searchingQrCode
    case inProcess
    case successful
    case failed
}

class ClaimNewLockerViewModel<C:RootCoordinator>: ViewModel<C>, ObservableObject {
    
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = "Qr-code goes here"
    @Published var claimLockerStep = ClaimLockerSteps.searchingQrCode
    
    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0
    
    private let apiService: ServiceProtocol
    private var lockerId: Int? = nil
    
    init(coordinator: C,
         apiService: ServiceProtocol) {
        self.apiService = apiService
        super.init(coordinator: coordinator)
    }
    
    func onFoundQrCode(_ code: String) {
        let index = code.index(code.startIndex, offsetBy: 7)
        guard let lockerId = Int(code.suffix(from: index)) else {
            return
        }
        self.lockerId = lockerId
        claimLockerStep = .inProcess
        Task {
            await apiService.claimLocker(withId: lockerId)
            DispatchQueue.main.async { [weak self] in
                self?.claimLockerStep = .successful
            }
        }
    }
    
    func showShareView(isPresented: Binding<Bool>) -> ShareView? {
        guard let lockerId = lockerId else {
            return nil
        }
        return coordinator?.showShareView(lockerId: lockerId, isPresented: isPresented)
    }
}
