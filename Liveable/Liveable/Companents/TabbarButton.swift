
import SwiftUI

struct TabbarButton: View {
    @Binding var currentTab: String
    private var isSelected: Bool { currentTab == title }
    let title: String
     let icon: String
    
    var body: some View {
        Button(action: buttonAction) {
            buttonLabel
        }
    }
}

// MARK: - View
extension TabbarButton {
    private var buttonLabel: some View {
        HStack {
            Image(systemName: icon)
            isSelected ?
            Text(title) : nil
        }
        .font(.system(size: 18))
            .foregroundColor(isSelected ? .white : .black)
            .padding()
            .background(isSelected ? Color.pink : .white)
            .cornerRadius(20)
    }
    
    private func buttonAction() {
        withAnimation {
            currentTab = title
        }
    }
}

struct TabbarButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TabbarButton(currentTab: .constant("Explore"), title: "Explore", icon: "network")
            TabbarButton(currentTab: .constant("Favorites"), title: "Favorites", icon: "heart")
        }
    }
}
