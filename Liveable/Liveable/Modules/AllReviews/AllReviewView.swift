

import SwiftUI


struct AllReviewView: View {
    
    @StateObject var viewModel = AllReviewViewModel()
    var selectedComment : Int = 0
    var advertId : Int
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { scrollView in
                LazyVStack{
                    Text("\(viewModel.advertCommentDic.count) Reviews")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // will show the selected comment
                    ForEach(viewModel.advertCommentDic.keys.sorted(by: <), id: \.self) { index in
                        AdvertComment(comment: viewModel.advertCommentDic[index])
                            .id(viewModel.advertCommentDic[index]?.id ?? 0)
                    }
                }
                .padding()
                .onAppear {
                    scrollView.scrollTo(selectedComment, anchor: .center)
                }
            }
        }.onAppear{
            viewModel.fetchAdvertComment(advertId: advertId)
        }
    }
}

struct AllReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AllReviewView(advertId: -1)
    }
}
