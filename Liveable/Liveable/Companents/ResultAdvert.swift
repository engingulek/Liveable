

import SwiftUI
import Kingfisher
struct ResultAdvert: View {
    let advert : Advert
    let guestItem:[GuestItem]
    @StateObject var viewModel = SearchResultViewModel()
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: advert.baseImageURL))
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: 100,height: 120)
                VStack(alignment:.leading,spacing: 5) {
                    Text(advert.title)
                        .font(.callout)
                        .fontWeight(.semibold)
                    Label("\(advert.location.city),\(advert.location.country)", systemImage: "mappin.circle")
                        .foregroundColor(.gray)
                        .font(.caption2)
                    
                    HStack {
                        VStack(alignment:.leading) {
                            Text("\(advert.roomCount.guest) guests")
                            Text("\(advert.roomCount.bedroom) bedrooms")
                        }
                        VStack(alignment:.leading) {
                            Text("\(advert.roomCount.bed) beds")
                            Text("\(advert.roomCount.bath) baths")
                        }
                    }.font(.caption2)
                    
                    Text("$\(viewModel.calculatorPrice(advert: advert, guestItms: guestItem).total)")
                    Text(viewModel.calculatorPrice(advert: advert, guestItms: guestItem).desc)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                   
                }
                Spacer()
            }
            
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
           
        }
    }
}

struct ResultAdvert_Previews: PreviewProvider {
    static var previews: some View {
        ResultAdvert(advert: Advert.advertExample,guestItem: [.init(id: 0, title: "Adult", subtitle: "", piece: 0)])
    }
}
