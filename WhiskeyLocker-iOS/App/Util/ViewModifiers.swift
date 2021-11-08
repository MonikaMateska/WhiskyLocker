import SwiftUI

struct FlatGlassView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 50)
            .background(.ultraThinMaterial)
            .cornerRadius(14)
    }
}

struct ConvexGlassView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 50)
            .background(.ultraThinMaterial)
            .overlay(LinearGradient(colors: [.clear, .black.opacity(0.2)], startPoint: .top, endPoint: .bottom))
            .cornerRadius(14)
            .shadow(color: .white.opacity(0.65), radius: 1, x: -1, y: -2)
            .shadow(color: .black.opacity(0.65), radius: 2, x: 2, y: 2)
    }
}

struct ButtonView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(ConvexGlassView())
            .cornerRadius(20)
    }
}
