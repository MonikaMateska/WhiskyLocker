import SwiftUI

struct FlashCard<Front, Back>: View where Front: View, Back: View {
    var front: () -> Front
    var back: () -> Back
    
    @Binding var flipped: Bool
    @Binding var flashcardRotation: Double
    @Binding var contentRotation: Double
    
    init(@ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back,
         flipped: Binding<Bool>,
         flashcardRotation: Binding<Double>,
         contentRotation: Binding<Double>) {
        self.front = front
        self.back = back
        self._flipped = flipped
        self._flashcardRotation = flashcardRotation
        self._contentRotation = contentRotation
    }
    
    var body: some View {
        ZStack {
            if flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .padding()
        .background(.ultraThinMaterial)
        .frame(width: getRect().width / 1.2)
        .foregroundColor(Color.primary.opacity(0.35))
        .foregroundStyle(.ultraThinMaterial)
        .cornerRadius(35)
        .padding()
        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
}
