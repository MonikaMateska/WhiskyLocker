import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel<RootCoordinatorLogic>
    @State var sheetViewShown = false
    
    var body: some View {
        ZStack {
            backgroundGeometries
            
            VStack(alignment: .leading) {
                Text("User")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .foregroundColor(Color.primary.opacity(0.4))
                
                Text("\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")")
                    .font(.subheadline)
                    .font(.system(size: 40))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                Text("Favourites")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .foregroundColor(Color.primary.opacity(0.4))
                
                Divider()
                
                Button {
                    sheetViewShown = true
                } label: {
                    Text("Help")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .foregroundColor(Color.primary.opacity(0.4))
                }
                
                Divider()
                
                Button {
                    viewModel.logoutTapped()
                } label: {
                    Text("Log Out")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .foregroundColor(Color.blue)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .frame(width: getRect().width / 1.2)
            .foregroundColor(Color.primary.opacity(0.35))
            .foregroundStyle(.ultraThinMaterial)
            .cornerRadius(35)
            .padding()
        }
        .navigationBarTitle("Settings")
        .sheet(isPresented: $sheetViewShown) {
            helpInfo
        }
    }
    
    private var helpInfo: some View {
        VStack {
            Spacer()
            Text("Help Info")
                .font(.title)
            Spacer()
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("blue").opacity(0.2))
                    .frame(width: getRect().width, height: getRect().height / 1.3)
                
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("blue").opacity(0.2))
                    .frame(width: getRect().width, height: getRect().height / 1.5)
                
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("blue").opacity(0.2))
                    .frame(width: getRect().width, height: getRect().height / 1.8)
            }
            .offset(y: -10)
        }
        .foregroundColor(.white)
        .background(Color("dark"))
    }
    
    private var backgroundGeometries: some View {
        GeometryReader { proxy in
            let height = proxy.frame(in: .global).height
            
            Circle()
                .fill(Color("dark"))
                .frame(width: 300)
                .offset(x: -getRect().width / 3.2, y: -height / 2)
                .animation(Animation.linear(duration: 0.5), value: 1)
            
            Circle()
                .fill(Color("dark"))
                .frame(width: 400)
                .offset(x: -getRect().width / 2, y: height / 2.3)
                .animation(Animation.linear(duration: 0.5), value: 1)
            
            Circle()
                .fill(Color("blue"))
                .offset(x: getRect().width / 2, y: 0)
        }
    }
}
