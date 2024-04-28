import SwiftUI

struct NotificationBadgeView: View {
    

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.red)
                .frame(width: 15, height: 15)

            Text("!")
                .foregroundColor(.white)
                .font(.system(size: 12))
        }
    }
}


