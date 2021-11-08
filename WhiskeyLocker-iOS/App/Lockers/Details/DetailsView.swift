import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel: DetailsViewModel<RootCoordinatorLogic>
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("dark"))
                .ignoresSafeArea()
            
            backgroundGeometries
            
            VStack {
                Text("Locker owner: \(viewModel.ownerUsername?.capitalized ?? "Locker has no owner")")
                    .font(.title)
                    .padding()
                
                Button {
                    viewModel.lockerStatus == .unlocked ? viewModel.lockLocker() : viewModel.unlockLocker()
                } label: {
                    HStack {
                        Text(viewModel.lockerStatus == .unlocked ? "Lock" : "Unlock")
                            .font(.system(size: 17))
                        Image(systemName: viewModel.lockerStatus == .unlocked ? "lock.fill" : "lock.open.fill")
                    }
                    .modifier(ButtonView())
                }
                
                Button {
                    viewModel.releaseLocker()
                } label: {
                    Text("Release")
                        .modifier(ButtonView())
                }
                
                Button {
                    viewModel.showShareScreen = true
                } label: {
                    HStack {
                        Text("Share")
                        Image(systemName: "square.and.arrow.up")
                    }
                    .modifier(ButtonView())
                }
                
            }
            .foregroundColor(.white)
        }
        .sheet(isPresented: $viewModel.showShareScreen, content: {
            viewModel.presentShareView(isPresented: $viewModel.showShareScreen)
        })
        .navigationBarTitle("Locker Details")
    }
    
    private var backgroundGeometries: some View {
        GeometryReader { proxy in
            let height = proxy.frame(in: .global).height
            
            Circle()
                .fill(Color("blue"))
                .offset(x: getRect().width / 2, y: height / 2.3)
        }
    }
}
