//
//  AdvertComment.swift
//  Liveable
//
//  Created by engin gülek on 4.10.2023.
//

import SwiftUI

struct AdvertComment: View {
    var stateLineLimit : Bool = false
    let comment: CommnetValue?
    var body: some View {
        VStack(alignment:.leading,spacing:10) {
            
            Text(comment?.commentText ?? "")
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
                    Text(comment?.commneterUser.nameSurname ?? "")
                        .font(.callout)
                    Text(comment?.commnetData ?? "")
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


//add will explation
/*struct AdvertComment_Previews: PreviewProvider {
    static var previews: some View {
        AdvertComment()
    }
}*/
