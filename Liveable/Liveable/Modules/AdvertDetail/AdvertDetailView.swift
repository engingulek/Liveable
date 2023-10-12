//
//  AdvertDetailView.swift
//  Liveable
//
//  Created by engin gülek on 27.09.2023.
//

import SwiftUI
import Kingfisher
import CoreLocation
import MapKit
struct AdvertDetailView: View {
    let advert:Advert
    @State private var index = 0
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Environment(\.dismiss) var dismiss
    @StateObject private var  viewModel = AdvertDetailViewModel()
    var body: some View {
    
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment:.leading) {
                   
                        advertImages
                        advertCityAndCountry
                        ownerInfo
                        advertDesc
                        VStack {
                            Map(coordinateRegion: $region)
                                        .frame(height: 200)
                                        .disabled(true)
                                        .cornerRadius(20)
                                        .padding(.horizontal)
                        }
                        comment
                    }
                   
                }
                reserver
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.top)
            .onAppear{
                viewModel.getUserInfo(userId: advert.userID)
                viewModel.fetchAdvertComment(advertId: advert.id)
                viewModel.fetchSavedList(id: advert.id)
            }
        }.tint(.black)
    }
}


//MARK : UI Component(s)
extension AdvertDetailView {
    private var advertImages : some View {
        VStack {
           
            ZStack(alignment:.top) {
                TabView(selection: $index) {
                   
                    ForEach(0..<advert.images.count,id:\.self) { index in
                        KFImage(URL(string: advert.images[index]))
                            .resizable()
                            .frame(height: 300)
                            .edgesIgnoringSafeArea(.top)
                           
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
               
                    .edgesIgnoringSafeArea(.top)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                    }.foregroundColor(.black)

                   
                    Spacer()
                    Image(systemName: viewModel.iconSystemImage)
                        .padding()
                        .background(.white)
                        .clipShape(Circle())
                        .onTapGesture {
                            viewModel.onTapHeartIcon(advert: advert)
                        }
                }.padding()
                    .padding(.vertical,25)
            }
           
                
        }.frame(height: 250)
    }
    
    private var advertCityAndCountry : some View {
        VStack(alignment:.leading,spacing:10) {
            Text("\(advert.title)")
                .font(.title)
                .fontWeight(.semibold)
            HStack {
                Image(systemName: "location.fill")
                    .font(.system(size: 18))
                Text("\(advert.location.city),\(advert.location.country)")
                    .font(.system(size: 18))
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(String(format: "%.1f", advert.rating))")
            }
        }.padding()
    }
    
    private var ownerInfo : some View {
        HStack {
            
            KFImage(URL(string: viewModel.userInfo.imageURL))
                .resizable()
                .frame(width: 55,height: 55)
               
                .clipShape(Circle())
           
                
            
           Text("\(viewModel.userInfo.nameSurname)")
                .font(.callout)
                .fontWeight(.semibold)
            Spacer()
            
            Image(systemName: "message")
                .font(.title3)
                .foregroundColor(.white)
                .padding(10)
                .background(.pink)
                .clipShape(Circle())
            
        }.padding(.horizontal)
    }
    
    private var advertDesc : some View {
        VStack(spacing:10) {
            Text(advert.decription)
                .font(.callout)
            HStack(alignment:.center) {
                Text(" \(advert.roomCount.guest) guests")
                   
                Text(" . \(advert.roomCount.bedroom) bedrooms")
                
                Text(" . \(advert.roomCount.bed) beds")
                
                Text(" . \(advert.roomCount.bath) baths")
            } .fontWeight(.semibold)
                .font(.callout)
                
        }.padding()
    }
    
    private var comment : some View {
        VStack {
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.advertCommentDic.keys.sorted(by: <), id: \.self) { index in
                        
                        NavigationLink {
                            AllReviewView(selectedComment: viewModel.advertCommentDic[index]?.id ?? 0, advertId: advert.id)
                        } label: {
                            AdvertComment(stateLineLimit: true, comment: viewModel.advertCommentDic[index])
                                .frame(width: UIScreen.main.bounds.width / 1.2)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            NavigationLink {
                AllReviewView(advertId: advert.id)
            } label: {
                Text("Show All Reviews")
                    .foregroundColor(.black)
                    .font(.title3)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(Color(.black), lineWidth: 2)
                    )
                    .padding()
            }
        }
        
    }
    
    private var reserver : some View {
        HStack {
            Text("$\(advert.price.adult) night")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            Button("Rezerve") {
                
            }
            .padding()
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width / 4)
            .background(Color.pink )
            .cornerRadius(10)
            
            
        }
        .padding(.top,20)
        .padding(.horizontal)
        .background(.white)
    }
}

struct AdvertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertDetailView(advert: Advert.advertExample)
    }
}
