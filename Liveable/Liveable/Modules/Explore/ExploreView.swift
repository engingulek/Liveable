//
//  Explore.swift
//  Liveable
//
//  Created by engin gülek on 24.09.2023.
//

import SwiftUI

struct ExploreView: View {
    @State private var categoryTab : String = "Populer"
    var body: some View {
        VStack {
            VStack {
                search
                categories
            }.background(
                Color.white 
                    .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                    .mask(Rectangle().padding(.bottom, -4))
            )
            listAdvert
           
            Spacer()
          
        }
    }
}


extension ExploreView {
    private var search: some View {
        HStack(spacing:20) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                VStack(alignment:.leading){
                    Text("To where?")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Perfect nature, clean air, zero sea")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .font(.callout)
                }
                Image(systemName: "slider.horizontal.3")
                    .font(.title2)
            }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    )
    }
    
    private var categories : some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 10) {
              CategoryTitle(categoryTab: $categoryTab, title: "Populer", icon: "flame")
                CategoryTitle(categoryTab: $categoryTab, title: "Shacks", icon: "shack")
            }
           
        }.padding()
        
    }
    
    private var listAdvert : some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing:35){
                    ForEach(0..<10) { _ in
                        AdvertDesign()
                    }
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
