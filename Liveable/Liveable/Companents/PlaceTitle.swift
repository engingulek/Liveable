//
//  PlaceTitle.swift
//  Liveable
//
//  Created by engin gülek on 28.09.2023.
//

import SwiftUI

struct PlaceTitle : View {
    @Binding var placeTab : Int
    private var isSelected : Bool {placeTab == id}
    let id : Int
    let title : String
    let image : String
    
    var body : some View {
        Button {
            buttonAction()
        } label: {
            place
        }

    }
}

extension PlaceTitle {
    private var place : some View {
        VStack(alignment:.leading) {
            Image(image)
                .resizable()
                .frame(width: 100,height:100)
                .border(isSelected ? .black : .white ,width: 2)
                .cornerRadius(10)
            Text(title)
                .font(.caption)
        }.foregroundColor(.primary)
       
    }
    
    private func buttonAction() {
        withAnimation {
           placeTab = id
        }
    }
}
