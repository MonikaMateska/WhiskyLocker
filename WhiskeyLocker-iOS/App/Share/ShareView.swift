import SwiftUI

struct ShareView: View {
    @ObservedObject var viewModel: ShareViewModel<RootCoordinatorLogic>
    
    var body: some View {
        content
    }
    
    private var content: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("dark"), Color("dark").opacity(0.8)]),
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .ignoresSafeArea()
                
                VStack {
                    List {
                        ForEach(viewModel.employees) { employee in
                            Button {
                                viewModel.employeeTapped(withId: employee.id)
                            } label: {
                                EmployeeCell(employee: employee,
                                             isSelected: viewModel.isEmployeeSelected(id: employee.id))
                            }
                        }
                    }
                    
                    Spacer()
                    
                    if viewModel.shouldShowShareButton {
                        Button {
                            viewModel.shareWithSelectedFriends()
                        } label: {
                            Text("Share with selected friends")
                                .modifier(ButtonView())
                        }
                    }
                }

            }
            .searchable(text: $viewModel.searchText)
            .foregroundColor(.white)
            .navigationTitle(Text("Employees"))
        }
    }
    
    private struct EmployeeCell: View {
        let employee: Employee
        let isSelected: Bool
        
        var body: some View {
            HStack {
                Label(employee.username, systemImage: isSelected ? "checkmark.circle.fill": "circle")
                    .foregroundColor(.black)
                Spacer()
            }
        }
    }
}
