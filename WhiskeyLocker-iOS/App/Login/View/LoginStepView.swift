import SwiftUI

struct LoginStepView: View {
    @ObservedObject var viewModel: LoginViewModel<LoginCoordinatorLogic>
    @Binding var expanded: Bool
    var flipFlashcard: () -> ()
    
    var body: some View {
        VStack {
            loginDescription
            loginInput
            loginButton
            registerButton
        }
    }
    
    private var loginDescription: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .foregroundColor(Color.primary.opacity(0.4))
            
            Text("Log in by using your username.")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .padding()
        }
    }
    
    private var loginInput: some View {
        VStack {
            TextField("Username", text: $viewModel.username)
                .autocapitalization(UITextAutocapitalizationType.words)
                .foregroundColor(.black)
                .modifier(FlatGlassView())
                .padding()
            
            SecureField("Password", text: $viewModel.password)
                .autocapitalization(UITextAutocapitalizationType.words)
                .foregroundColor(.black)
                .modifier(FlatGlassView())
                .padding()
        }
    }
    
    private var loginButton: some View {
        Button {
            viewModel.loginPressed()
        } label: {
            ZStack {
                Text("LOG IN")
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .cornerRadius(14)
                    .padding(.bottom, 8)
                    .modifier(ConvexGlassView())
            }
        }
    }
    
    private var registerButton: some View {
        Button {
            flipFlashcard()
        } label: {
            Text("Register")
                .bold()
                .padding(8)
        }
    }
}
