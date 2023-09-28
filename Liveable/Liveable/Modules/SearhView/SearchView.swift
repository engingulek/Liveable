//
//  SearchView.swift
//  Liveable
//
//  Created by engin gülek on 28.09.2023.
//

import SwiftUI

private struct MapItems {
    var id:Int
    var image:String
    var title:String
    
    
    static let items : [MapItems] = [
        MapItems(id: 0, image: "earth", title: "Flexible Search"),
        MapItems(id: 2, image: "turkey", title: "Türkiye"),
        MapItems(id: 3, image: "usa", title: "USA")
        
    ]
}

private struct GuestItem {
    var id : Int
    var title : String
    var subtitle : String
    @State var piece : Int
    
    static let items : [GuestItem] = [
        GuestItem(id: 0, title: "Adults", subtitle: "13+",piece: 1),
        GuestItem(id: 1, title: "Kids", subtitle: "2-12",piece: 0),
        GuestItem(id: 2, title: "Babay", subtitle: "0-2",piece: 0)
        
    ]
}



struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentTab : Int = 0
    @State private var placeStatus : Bool = true
    @State private var guestStatus : Bool = false
    
    
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
            
            
            if viewModel.searhAction {
                VStack {
                    header
                    searchViewList
                  
                    Spacer()
                }   .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .padding()
            }else {
                if placeStatus {
                    openPlace
                }else{
                    closePlace
                }
                
                
                if guestStatus {
                    openGuests
                }else{
                    closeGuest
                }
                
                Button {
                    
                } label: {
                    Text("Search")
                        .foregroundColor(.white)
                        .padding()
                        .font(.title3)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .background(Color.pink )
                        .cornerRadius(10)
                        .padding(.horizontal)}
            }
            
            
            
           
           
            Spacer()
        }.background(Color.gray.opacity(0.1))
        
        
        
        
        
    }
}


extension SearchView {
    private var header: some View {
        VStack {
            Text("To Where")
                .font(.title)
            search
            
        }
    }
    private var search: some View {
        HStack(spacing:20) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
            VStack(alignment:.leading){
                TextField("Search for destination",text:$viewModel.searchText)
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
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing:30) {
                    ForEach(MapItems.items,id:\.id) { item in
                        PlaceTitle(placeTab: $currentTab, id: item.id, title: item.title, image: item.image)
                    }
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
            Text("Flexible Search")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        .onTapGesture {
            withAnimation(.linear) {
                self.placeStatus = true
                self.guestStatus = false
            }
        }
    }
    
    private var openGuests : some View {
        VStack(alignment: .leading,spacing: 10) {
            Text("Who is coming")
                .font(.title)
            ForEach(GuestItem.items,id: \.id) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .foregroundColor(.black)
                        Text(item.subtitle)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "minus.circle")
                            .foregroundColor(item.piece == 0 ? .gray : .black)
                            .font(.title2)
                    }
                    
                    
                    Text("\(item.piece)")
                        .font(.title3)
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.black)
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
            Text("1")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        .onTapGesture {
            withAnimation(.linear) {
                self.placeStatus = false
                self.guestStatus = true
            }
        }
    }
    
    private var searchViewList : some View {
        ScrollView {
            ForEach(0..<3,id:\.self) { item in
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(10)
                        .padding()
                      Text("İstanbul,Türkiye")
                    Spacer()
                   
                }
                Divider()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


/*
 
 Button {
     
 } label: {
     Text("Search")
         .foregroundColor(.white)
         .padding()
         .font(.title3)
         .frame(width: UIScreen.main.bounds.width / 1.5)
         .background(Color.pink )
         .cornerRadius(10)
         .padding(.horizontal)}
 
 
*/
