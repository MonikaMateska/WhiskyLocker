import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel<LoginCoordinatorLogic>
    @State var expanded = false
    @State var flipped = false
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    
    var body: some View {
        ZStack {
            backgroundGeometries
            
            FlashCard<LoginStepView, RegisterStepView>(front:  {
                LoginStepView(viewModel: viewModel,
                              expanded: $expanded,
                              flipFlashcard: flipFlashcard)
            }, back: {
                RegisterStepView(viewModel: viewModel,
                                 flipFlashcard: flipFlashcard)
            }, flipped: $flipped, flashcardRotation: $flashcardRotation, contentRotation: $contentRotation)
        }
    }
    
    func flipFlashcard() {
        let animationTime = 0.5
        
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += 180
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += 180
            flipped.toggle()
        }
    }
    
    private var backgroundGeometries: some View {
        GeometryReader { proxy in
            let height = proxy.frame(in: .global).height
            
            Circle()
                .fill(Color("dark"))
                .frame(width: expanded ? 400 : 100)
                .offset(x: expanded ? -getRect().width / 2 : getRect().width / 2,
                        y: expanded ? -height / 2.3 : 0 )
                .animation(Animation.linear(duration: 0.5), value: 1)
                .onAppear {
                    withAnimation {
                        expanded.toggle()
                    }
                }
            
            Circle()
                .fill(Color("blue"))
                .offset(x: getRect().width / 2, y: 0)
        }
    }
}
