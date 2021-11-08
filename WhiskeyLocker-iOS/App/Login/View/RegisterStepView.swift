import SwiftUI

struct RegisterStepView: View {
    @ObservedObject var viewModel: LoginViewModel<LoginCoordinatorLogic>
    var flipFlashcard: () -> ()
    
    var body: some View {
        VStack {
            registerDescription
            registerInput
            registerButton
            loginButton
        }
    }
    
    private var registerDescription: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .foregroundColor(Color.primary.opacity(0.4))
            
            Text("Please enter the required data in order to create an account.")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .padding()
        }
    }
    
    private var registerInput: some View {
        VStack(spacing: 8) {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(UITextAutocapitalizationType.words)
                .foregroundColor(.black)
                .modifier(FlatGlassView())
            
            TextField("First Name", text: $viewModel.firstName)
                .autocapitalization(UITextAutocapitalizationType.words)
                .foregroundColor(.black)
                .modifier(FlatGlassView())
            
            TextField("Last Name", text: $viewModel.lastName)
                .autocapitalization(UITextAutocapitalizationType.words)
                .foregroundColor(.black)
                .modifier(FlatGlassView())
            
            TextField("Username", text: $viewModel.username)
                .autocapitalization(UITextAutocapitalizationType.words)
                .foregroundColor(.black)
                .modifier(FlatGlassView())
            
            SecureField("Password", text: $viewModel.password)
                .autocapitalization(UITextAutocapitalizationType.words)
                .foregroundColor(.black)
                .modifier(FlatGlassView())
        }
        .padding()
    }
    
    private var registerButton: some View {
        Button {
            viewModel.registerPressed()
        } label: {
            ZStack {
                Text("REGISTER")
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .cornerRadius(14)
                    .padding(.bottom, 8)
                    .modifier(ConvexGlassView())
            }
        }
    }
    
    private var loginButton: some View {
        Button {
            flipFlashcard()
        } label: {
            Text("Log In")
                .bold()
                .padding(8)
        }
    }
}
