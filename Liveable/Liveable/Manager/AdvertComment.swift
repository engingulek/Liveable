//
//  AdvertComment.swift
//  Liveable
//
//  Created by engin gülek on 4.10.2023.
//

import SwiftUI

struct AdvertComment: View {
    var stateLineLimit : Bool = false
    var body: some View {
        VStack(alignment:.leading,spacing:10) {
            
            Text("He is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It ha")
                .lineLimit(stateLineLimit ? 4 : 10)
                .font(.callout)
            
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .background(.pink)
                    .clipShape(Circle())
                VStack(alignment:.leading){
                    Text("Name")
                        .font(.callout)
                    Text("2 month ago")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                Spacer()
                
            }
            
        }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color(.gray), lineWidth: 2)
            )
            .padding()
    }
}

struct AdvertComment_Previews: PreviewProvider {
    static var previews: some View {
        AdvertComment()
    }
}
