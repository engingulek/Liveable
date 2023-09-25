//
//  AdvertDesign.swift
//  Liveable
//
//  Created by engin gülek on 25.09.2023.
//

import SwiftUI
import Kingfisher
struct AdvertDesign: View {
    var body: some View {
        VStack(alignment:.leading,spacing:10) {
            ZStack(alignment:.topTrailing) {
                KFImage(URL(string: "https://a0.muscache.com/im/pictures/miso/Hosting-664438232928897086/original/f5a2dd5b-588f-4abc-add3-1924f1360565.jpeg?im_w=1200"))
                    .resizable()
                    .frame(height: UIScreen.main.bounds.height / 4)
                    .cornerRadius(20)
                Image(systemName: "heart")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
            }
           
               
            HStack {
                Text("Tree Home - Rize,Turkey")
                   
                    .fontWeight(.semibold)
                Spacer()
                HStack(spacing:2){
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("4,5(200)")
                }
            }
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the.... ")
                .font(.footnote)
                .foregroundColor(.gray)
            HStack(spacing:2) {
                Spacer()
                Text("$ 200")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(" night")
            }
        }.padding()
      
           
    }
}

struct AdvertDesign_Previews: PreviewProvider {
    static var previews: some View {
        AdvertDesign()
    }
}
