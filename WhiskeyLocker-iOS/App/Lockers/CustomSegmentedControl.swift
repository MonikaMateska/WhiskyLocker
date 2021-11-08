import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var lockerFilter: LockerFilter
    @Namespace var animation
    
    var body: some View {
        HStack {
            Text("My Lockers")
                .fontWeight(.bold)
                .padding(.horizontal, 25)
                .padding(.vertical, 12)
                .background (
                    ZStack {
                        if lockerFilter == .myLockers {
                            Color.white
                                .cornerRadius(10)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                )
                .foregroundColor(lockerFilter == .myLockers ? .black : .white)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        lockerFilter = .myLockers
                    }
                }
            
            Text("Shared lockers")
                .fontWeight(.bold)
                .padding(.horizontal, 25)
                .padding(.vertical, 12)
                .background (
                    ZStack {
                        if lockerFilter == .sharedLockers {
                            Color.white
                                .cornerRadius(10)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                )
                .foregroundColor(lockerFilter == .sharedLockers ? .black : .white)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        lockerFilter = .sharedLockers
                    }
                }
        }
        
        .padding(.vertical, 7)
        .padding(.horizontal, 10)
        .background(Color.black.opacity(0.35))
        .cornerRadius(10)
        .padding(.top)
        
    }
}
