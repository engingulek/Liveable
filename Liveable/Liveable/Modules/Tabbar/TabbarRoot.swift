
import SwiftUI

struct TabbarRoot:View {
    @State private var currentTab: String = "Explore"
    @State private var loginState : Bool = false
   
    var body: some View {
       
            TabView(selection: $currentTab) {
                ExploreView()
                    .tag("Explore")
                SavedView()
                    .tag("Saved")
              
            }.overlay(alignment: .bottom) {
                bottomTabbarStack
            }.ignoresSafeArea(.keyboard, edges: .bottom)
                .padding(.bottom)
        }
}


extension TabbarRoot {
    private var  bottomTabbarStack : some View {
        HStack(spacing:5) {
            TabbarButton(currentTab: $currentTab, title: "Explore", icon: "network")
            TabbarButton(currentTab: $currentTab, title: "Saved", icon: "heart")
           
          
        }
    }
}

struct TabbarRoot_Previews: PreviewProvider {
    static var previews: some View {
        TabbarRoot()
    }
}


