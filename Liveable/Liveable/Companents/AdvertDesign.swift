//
//  AdvertDesign.swift
//  Liveable
//
//  Created by engin gülek on 25.09.2023.
//

import SwiftUI
struct AdvertDesign: View {
    let advert  : Advert
    
    var body: some View {
        VStack(alignment:.leading,spacing:10) {
           
                AsyncImage(url: URL(string: advert.baseImageURL)) { image in
                    image.image?.resizable()
                        .frame(height: UIScreen.main.bounds.height / 4)
                        .cornerRadius(20)
                }
            
            HStack {
                Text("\(advert.title)- \(advert.location.city),\(advert.location.country)")
                    .fontWeight(.semibold)
                Spacer()
                HStack(spacing:2){
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(String(format: "%.1f", advert.rating))")
                }
            }
            
            Text(advert.decription)
                .font(.footnote)
                .foregroundColor(.gray)
            HStack(spacing:2) {
                Spacer()
                Text("\(advert.price.adult)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(" night")
            }
        }.padding()
      
           
    }
}



struct AdvertDesign_Previews: PreviewProvider {
    static var previews: some View {
        AdvertDesign(advert: Advert.advertExample)
    }
}
