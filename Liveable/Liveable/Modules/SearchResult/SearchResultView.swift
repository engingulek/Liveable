

import SwiftUI
import Kingfisher
struct SearchResultView: View {
    let searchText : String
    let guest : [GuestItem]
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SearchResultViewModel()
  
    var body: some View {
        VStack(alignment:.leading) {
            
            ScrollView {
                Image(systemName: "multiply.circle")
                    .font(.title)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.vertical)
                Text("Search Result").font(.title3)
                
                
                Text("\(viewModel.searchAdvertList.count) Advert")
                ForEach(viewModel.searchAdvertList.keys.sorted(by: <),id:\.self) { index in
                    ResultAdvert(advert: viewModel.searchAdvertList[index] ?? Advert.advertExample, guestItem: guest)
                }
            }
            Spacer()
        }
            .onAppear{
                viewModel.searchAdvert(searchText: searchText)
            }
        
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchText: "", guest: [.init(id: 0, title: "ewqe", subtitle: "", piece: 0)])
    }
}
