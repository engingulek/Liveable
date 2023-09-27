//
//  Explore.swift
//  Liveable
//
//  Created by engin gülek on 24.09.2023.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private  var exploreViewModel = ExploreViewModel()
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                        search
                        categories
                    }.background(
                        Color.white
                            .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                            .mask(Rectangle().padding(.bottom, -4))
                    )
                if exploreViewModel.isPageLoaded {
                    if exploreViewModel.isError {
                        VStack(alignment:.center) {
                            Image(exploreViewModel.errorMessage.icon)
                                .resizable()
                                .frame(width: 100,height: 100)
                            Text(exploreViewModel.errorMessage.message)
                                .font(.title2)
                        }.padding(.top,100)
                    }else{
                        listAdvert
                    }
                }else{
                  ProgressView()
                  
                }
                Spacer()
            }
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
            HStack(spacing: 20) {
                CategoryTitle(categoryTab: $exploreViewModel.categoryTab,id: 0, title: "Populer", icon: "flame")
                CategoryTitle(categoryTab: $exploreViewModel.categoryTab,id: 1, title: "Shacks", icon: "shack")
                
                CategoryTitle(categoryTab: $exploreViewModel.categoryTab,id: 2, title: "Beachfront", icon: "beachfront")
                
                CategoryTitle(categoryTab: $exploreViewModel.categoryTab,id: 3, title: "Boats", icon: "boat")
                CategoryTitle(categoryTab: $exploreViewModel.categoryTab,id: 4, title: "Treehouses", icon: "treehouse")
            }
           
        }.padding()
        
    }
    
    private var listAdvert : some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing:35){
                    ForEach(exploreViewModel.advertList,id:\.id) { advert in
                        NavigationLink {
                            AdvertDetailView(advert: advert)
                                .edgesIgnoringSafeArea(.top)
                              
                        } label: {
                            AdvertDesign(advert: advert)
                                .foregroundColor(.primary)
                        }

                      
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
