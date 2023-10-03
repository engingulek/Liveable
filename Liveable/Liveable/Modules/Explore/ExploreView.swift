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
                    NavigationLink {
                        SearchView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        search
                            .foregroundColor(.primary)
                    }
                    
                    if exploreViewModel.isCategoryLoaded {
                        categories
                    }else{
                      ProgressView()
                        .padding()
                    }
                        
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
                        if exploreViewModel.isEmptyData {
                            VStack(alignment:.center) {
                                Image(exploreViewModel.defaultMessage.icon)
                                    .resizable()
                                    .frame(width: 100,height: 100)
                                Text(exploreViewModel.defaultMessage.message)
                                    .font(.title2)
                            }.padding(.top,100)
                        }else{
                           listAdvert
                        }
                        
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
                ForEach(exploreViewModel.categoryList,id: \.id) { category  in
                    CategoryTitle(categoryTab: $exploreViewModel.categoryTab,
                                  id: category.id,
                                  title: category.name,
                                  imageUrl: category.imageURL,
                                  viewModel:exploreViewModel
                    
                    )
                   
                   
                   
                }
            }
           
        }.padding()
        
    }
    
    private var listAdvert : some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing:35){
                    
                    ForEach(exploreViewModel.advertList,id:\.id) { advert in
                        
                        AdvertDesign(advert: advert)
                            .foregroundColor(.primary)
                            .onTapGesture {
                                exploreViewModel.changeToAdvertDetailView()
                            }.fullScreenCover(isPresented: $exploreViewModel.isToAdvertDetailView) {
                                AdvertDetailView(advert: advert)
                                    .edgesIgnoringSafeArea(.top)
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
