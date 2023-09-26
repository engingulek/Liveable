//
//  CategoryTitle.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import SwiftUI

struct CategoryTitle: View {
    @Binding var categoryTab : String
    private var isSelected : Bool { categoryTab == title}
    let title : String
    let icon : String
    var body: some View {
        Button {
            buttonAction()
        } label: {
            category
        }
    }
}


extension CategoryTitle {
    private var category : some View {
        VStack {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30,height: 30)
                .foregroundColor(.red)
            Text(title)
                .fontWeight(isSelected ? .semibold : .light)
                .foregroundColor(.black)
                .font(.callout)
        }.opacity(isSelected ? 1 : 0.5)
    }
    
    private func buttonAction() {
        withAnimation {
            categoryTab = title
        }
    }
}

struct CategoryTitle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CategoryTitle(categoryTab: .constant("Populer"), title: "Populer", icon: "flame")
            CategoryTitle(categoryTab: .constant("Shack"), title: "Shacks", icon: "shack")
        }
       
    }
}
