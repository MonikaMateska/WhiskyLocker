import SwiftUI

struct ClaimNewLockerView: View {
    @ObservedObject var viewModel: ClaimNewLockerViewModel<RootCoordinatorLogic>
    @State var sheetViewShown = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("dark"))
                .ignoresSafeArea()
            
            switch viewModel.claimLockerStep {
            case .searchingQrCode:
                scanQrCode
            case .successful:
                scanQrCodeSuccess
            default:
                //TODO: add loading view
                EmptyView()
            }
        }
        .sheet(isPresented: $sheetViewShown) {
            viewModel.showShareView(isPresented: $sheetViewShown)
        }
        .navigationTitle(navigationTitle)
    }
    
    private var navigationTitle: String {
        switch viewModel.claimLockerStep {
        case .searchingQrCode:
            return "Claim New Locker"
        case .inProcess:
            return "Loading..."
        case .successful:
            return "The locker is yours!"
        case .failed:
            return "Failed to claim the locker"
        }
    }
    
    private var scanQrCode: some View {
        ZStack {
            QrCodeScannerView()
                .found(r: viewModel.onFoundQrCode)
                .torchLight(isOn: viewModel.torchIsOn)
                .interval(delay: viewModel.scanInterval)
                .cornerRadius(50)
                .padding(20)
                .padding(.bottom, 100)
            
            VStack {
                Spacer()
                
                Text("Scan the locker's QR code")
                    .foregroundColor(.white)
                
                Button(action: {
                    self.viewModel.torchIsOn.toggle()
                }, label: {
                    Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                        .imageScale(.large)
                        .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                        .modifier(ButtonView())
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                })
            }
            .padding()
        }
    }
    
    private var scanQrCodeSuccess: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("You have successfully claimed the locker!")
                .font(.title)
                .bold()
            
            Text("Keep safe your whisky and share it with your friends 😁")
                .padding(.bottom)
            
            Text("🎉")
                .font(.system(size: 100))
            Spacer()
            
            Button {
                sheetViewShown = true
            } label: {
                Text("Share with friends")
                    .modifier(ButtonView())
            }
            
            Spacer()
        }
        .foregroundColor(.white)
    }
}
