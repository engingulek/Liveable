//
//  AllReviewView.swift
//  Liveable
//
//  Created by engin gülek on 4.10.2023.
//

import SwiftUI


struct AllReviewView: View {
    
    var selectedComment : Int = 0
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { scrollView in // --> Here
                LazyVStack{
                    
                    ForEach(Comment.comments.indices, id: \.self) { index in
                        AdvertComment()
                        // .id(Comment.comments[index])
                    }
                }
                .padding()
                .onAppear {
                    scrollView.scrollTo(selectedComment, anchor: .center) // ---> Here
                }
            }
        }
    }
}

struct AllReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AllReviewView()
    }
}
