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
    @State private var currentTab : Int = 0
    @State private var openPlace : Bool = true
    @State private var openGuest : Bool = false
    var body: some View {
        
        VStack {
            if openPlace {
                place
            }else{
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
                        self.openPlace = true
                        self.openGuest = false
                    }
                }
            }
            
            if openGuest {
               guests
            }else{
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
                        self.openPlace = false
                        self.openGuest = true
                    }
                }
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
                    .padding(.horizontal)
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
                       Text("Search for destination")
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
    
    
    private var place :  some View {
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
    
    private var guests : some View {
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
