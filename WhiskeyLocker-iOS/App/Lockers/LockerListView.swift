import SwiftUI

struct LockerListView: View {
    @ObservedObject var viewModel: LockerListViewModel<RootCoordinatorLogic>
    
    var body: some View {
        VStack {
            titleWithAction
                .padding()
            
            CustomSegmentedControl(lockerFilter: $viewModel.lockerFilter)
            
            lockersLists
            
            claimNewLockerButton
        }
        .background(Color("dark"))
        .navigationBarTitle("Home")
        .navigationBarHidden(true)
    }
    
    private var titleWithAction: some View {
        HStack {
            Text("Home")
                .font(.system(size: 40))
                .bold()
            Spacer()
            
            NavigationLink(destination: viewModel.showSettingsView()) {
                Image(systemName: "person")
                    .font(.system(size: 25))
            }
        }
        .foregroundColor(.white)
    }
    
    private var lockersLists: some View {
        ScrollView(showsIndicators: false) {
            if viewModel.lockerFilter == .myLockers {
                LockerViewItem(lockers: viewModel.myLockers, viewModel: viewModel)
            } else {
                VStack {
                    LockerViewItem(lockers: viewModel.sharedLockers, viewModel: viewModel)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            viewModel.getLockers()
        }
    }
    
    private var claimNewLockerButton: some View {
        NavigationLink {
            viewModel.showClaimNewLocker()
        } label: {
            Text("Claim new locker")
                .foregroundColor(.white)
                .modifier(ButtonView())
        }
    }
}

struct LockerCell: View {
    let id: Int
    let imageName: String
    var body: some View {
        HStack {
            Text("\(id)")
            Spacer()
            Image(systemName: imageName)
        }
        .frame(height: 40)
        .foregroundColor(.black)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct LockerViewItem: View {
    var lockers: [LockerResponse]
    var viewModel: LockerListViewModel<RootCoordinatorLogic>
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(lockers) { locker in
                    NavigationLink(destination: viewModel.showDetailsView(locker: locker)) {
                        LockerCell(id: locker.id, imageName: "chevron.right")
                    }
                }
            }
        }
        .padding([.bottom, .top])
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}
