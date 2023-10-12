//
//  Favorites.swift
//  Liveable
//
//  Created by engin gülek on 24.09.2023.
//

import SwiftUI

struct SavedView: View {
    @StateObject private var viewModel = SavedViewModel()
    var body: some View {
        VStack {
            if viewModel.isLoadingPage {
                if viewModel.isError {
                    VStack(alignment:.center) {
                        Image(viewModel.isMessage.icon)
                            .resizable()
                            .frame(width: 100,height: 100)
                        Text(viewModel.isMessage.message)
                            .font(.title2)
                    }.padding(.top,100)
                }else{
                    
                    if viewModel.isEmptyData {
                        
                        VStack(alignment:.center) {
                            Image(viewModel.isMessage.icon)
                                .resizable()
                                .frame(width: 100,height: 100)
                            Text(viewModel.isMessage.icon)
                                .font(.title2)
                        }.padding(.top,100)
                    }else{
                        listAdvert
                    }
                }
            }else{
                ProgressView()
            }
        }
     
    }
}

extension SavedView {
    private var listAdvert : some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing:35){
                    Text("\(viewModel.savedList.count) Advert")
                        .padding(.vertical)
                        .font(.title2)
                        .fontWeight(.semibold)
                    ForEach(viewModel.savedList.keys.sorted(by: <),id: \.self) { index  in
                        AdvertDesign(advert: viewModel.savedList[index] ?? Advert.advertExample)
                            .onTapGesture {
                                viewModel.changeToDetailView()
                            }.fullScreenCover(isPresented: $viewModel.toDetailView) {
                                AdvertDetailView(advert: viewModel.savedList[index] ?? Advert.advertExample)
                            }
                    }
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
       SavedView()
    }
}
