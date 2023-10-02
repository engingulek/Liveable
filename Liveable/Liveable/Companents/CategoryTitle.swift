//
//  CategoryTitle.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import SwiftUI
import Kingfisher
struct CategoryTitle: View {
    @Binding var categoryTab : Int
    private var isSelected : Bool { categoryTab == id}
    let id : Int
    let title : String
    let imageUrl : String
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
            KFImage(URL(string: imageUrl))
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
            categoryTab = id
        }
    }
}

struct CategoryTitle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ForEach(Category.categoryExample,id: \.id) { category in
                CategoryTitle(categoryTab: .constant(0), id: category.id, title: category.name, imageUrl: category.imageURL)
            }
        }
       
    }
}
