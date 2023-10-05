//
//  SearchView.swift
//  Liveable
//
//  Created by engin gülek on 28.09.2023.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentTab : Int = 0
    @StateObject var viewModel = SearhViewModel()
  
    var body: some View {
        
        VStack {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .font(.title3)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .foregroundColor(.primary)
                }
            }
            
            
            if viewModel.searhAction && !viewModel.isExitSearchList {
                VStack {
                    header
                   
                    searchViewList
                    
                    Spacer()
                }   .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .padding()
            }else {
                if viewModel.placeStatus {
                    openPlace
                }else{
                    closePlace
                }
                if viewModel.guestStatus {
                    openGuests
                }else{
                    closeGuest
                }
                
                Button {
                    viewModel.toSearchResultViewAction()
                } label: {
                    Text("Search")
                        .foregroundColor(.white)
                        .padding()
                        .font(.title3)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .background(Color.pink )
                        .cornerRadius(10)
                    .padding(.horizontal)
                    
                }.fullScreenCover(isPresented: $viewModel.isToSearchResultView) {
                    SearchResultView(searchText: viewModel.searchText, guest: viewModel.guestList)
                }
            }
              
            Spacer()
        }.background(Color.gray.opacity(0.1))
    }
}

// MARK: View Component(s)
extension SearchView {
    
    //Header
    private var header: some View {
        VStack {
            Text("To Where")
                .font(.title)
            search
            
        }
    }
    //Search
    private var search: some View {
        HStack(spacing:20) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
            VStack(alignment:.leading){
                TextField("Search for City",text:$viewModel.searchText)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.callout)
            }
        }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
            )
    }
    
    private var openPlace :  some View {
        VStack {
            header
            Text("or by country search")
                .padding()
                .foregroundColor(.pink)
                .fontWeight(.semibold)
            ScrollView(.horizontal,showsIndicators: false) {
                if viewModel.isMapCountryListLoded {
                    if !viewModel.isMapCountryListError {
                        HStack(spacing:30) {
                            ForEach(viewModel.mapCountryList,id:\.id) { item in
                                PlaceTitle(placeTab: $currentTab, id: item.id, title: item.title, image: item.imageURL,viewModel: viewModel)
                            }
                        }
                    }else{
                        Text(viewModel.isMapCountryListErrorMessage)
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                }else{
                    ProfileView().padding(50)
                }
               
            }.padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }
    
    private var closePlace : some View {
        HStack {
            Text("Place")
            Spacer()
            Text(viewModel.searchText)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        .onTapGesture {
            withAnimation(.linear) {
                viewModel.placeAction()
            }
        }
    }
    
    private var openGuests : some View {
        VStack(alignment: .leading,spacing: 10) {
            Text("Who is coming")
                .font(.title)
            ForEach(viewModel.guestList,id: \.id) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .foregroundColor(.black)
                        Text(item.subtitle)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    Button {
                        viewModel.decreaseGuest(guestId: item.id)
                    } label: {
                        Image(systemName: "minus.circle")
                            .foregroundColor(Color["\(viewModel.addAndDecraseButtonColot(piece: item.piece).decrase)"])
                            .font(.title2)
                    }.disabled(viewModel.decraseButtonDisabled(guestId: item.id))
                    
                    Text("\(item.piece)")
                        .font(.title3)
                        .frame(width: 30)
                    Button {
                        viewModel.addGuest(guestId: item.id)
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color["\(viewModel.addAndDecraseButtonColot(piece: item.piece).add)"])
                            .font(.title2)
                    }
                }
            }
        }.padding(20)
            .background(Color.white)
            .cornerRadius(20)
        
            .padding()
    }
    
    private var closeGuest : some View {
        HStack {
            Text("Guest")
            Spacer()
            Text("\(viewModel.totalGuest)")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        .onTapGesture {
            withAnimation(.linear) {
                viewModel.guestAction()
            }
        }
    }
    
    private var searchViewList : some View {
        ScrollView {
            ForEach(viewModel.cityList,id:\.id) { city in
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(10)
                        .padding()
                    Text(city.title)
                    Spacer()
                    
                }.onTapGesture {
                    viewModel.selectedLocation(text: city.title)
                    
                }
                Divider()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
        }
        
    }
}

