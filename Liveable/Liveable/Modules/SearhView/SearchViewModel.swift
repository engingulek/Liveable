//
//  SearchViewModel.swift
//  Liveable
//
//  Created by engin gülek on 28.09.2023.
//

import Foundation


struct GuestItem  : Codable{
    var id : Int
    var title : String
    var subtitle : String
    var piece : Int
}

protocol SearchViewModelProtocol : ObservableObject {
    var placeStatus : Bool {get}
    var guestStatus : Bool {get}
    var searhAction : Bool {get}
    var isExitSearchList : Bool {get}
    var totalGuest : Int {get}
    var isMapCountryListLoded : Bool {get}
    var isMapCountryListError : Bool {get}
    var isMapCountryListErrorMessage : String {get}
    var isToSearchResultView : Bool {get}
      
    func selectedLocation(text:String)
    func placeAction()
    func guestAction()
    func addGuest(guestId id : Int)
    func  decreaseGuest(guestId id: Int)
    func decraseButtonDisabled(guestId id : Int) -> Bool
    func changeisMapCountryListLoded()
    func changeisMapCountryListError()
    func toSearchResultViewAction()
    
  
  
    
    
}

final class SearhViewModel :  SearchViewModelProtocol  {
    private let serviceManager : SearchServiceProtocol
    @Published var searchText : String = ""
    @Published var isExitSearchList : Bool = false
    @Published var placeStatus : Bool = true
    @Published var guestStatus : Bool = false
    @Published var guestList : [GuestItem] = []
    @Published var totalGuest : Int  = 0
    @Published var cityList : City = []
    @Published var mapCountryList : MapCountry = []
    @Published var isMapCountryListLoded: Bool = false
    @Published var isMapCountryListError: Bool = false
    @Published var isMapCountryListErrorMessage: String = ""
    @Published var isToSearchResultView: Bool = false
   
    
    init(serviceManager : SearchServiceProtocol = SearchService.shared){
        self.serviceManager = serviceManager
        self.getGuestList()
        self.fetchMapCountyList()
    }
    
    var searhAction : Bool {
        if searchText.count >= 3 {
            self.searchCity(searchText: searchText)
            return true
        }else{
            return false
        }
    }
    
    
    private func getGuestList(){
         self.guestList = [
             GuestItem(id: 0, title: "Adult", subtitle: "13+",piece: 0),
             GuestItem(id: 1, title: "Kid", subtitle: "2-12",piece: 0),
             GuestItem(id: 2, title: "Baby", subtitle: "0-2",piece: 0)
             
         ]
     }
    
  private func searchCity(searchText text:String) {
        serviceManager.fetchCityList { result in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    let searchList = list.filter{$0.title.lowercased().contains(text.lowercased())}
                    self.cityList = searchList
                }
            case .failure(let error):
                if error.localizedDescription != "200"{
                    self.cityList = []
                }
               
                
            }
        }
    }
    
    private func fetchMapCountyList() {
        serviceManager.fetchMapCountryList { result in
            switch result {
            case .success(let list):
                self.changeisMapCountryListLoded()
                DispatchQueue.main.async {
                    self.mapCountryList = list
                }
            case .failure(let error):
                self.changeisMapCountryListLoded()
                self.changeisMapCountryListError()
                if error as! CustomError == CustomError.networkError {
                    self.isMapCountryListErrorMessage = "Network Error"
                }else{
                    self.isMapCountryListErrorMessage = "Something Went Wrong"
                }
            }
        }
    }
}


extension SearhViewModel {
    func selectedLocation(text: String) {
        DispatchQueue.main.async {
            self.isExitSearchList = true
            self.searchText = text
            self.placeStatus = false
            self.guestStatus = true
            
        }
    }
    
    func guestAction() {
        self.placeStatus = false
        self.guestStatus = true
    }
    
    func placeAction() {
        self.placeStatus = true
        self.guestStatus = false
    }
    
   
    
    func addGuest(guestId id: Int) {
        guestList[id].piece += 1
        let newGuest = guestList[id]
        guestList[id] =  newGuest
        totalGuest = guestList.lazy.compactMap{$0.piece}.reduce(0,+)
        
    }
    
    func decreaseGuest(guestId id: Int) {
        guestList[id].piece -= 1
        let newGuest = guestList[id]
        guestList[id] =  newGuest
        totalGuest = guestList.lazy.compactMap{$0.piece}.reduce(0,+)
    }
    
    func addAndDecraseButtonColot(piece:Int) -> (decrase:String,add:String) {
        let decrase : String
        let add : String
        
        if piece == 0 {
            decrase = "gray"
            add = "black"
        }else{
            decrase = "black"
            add = "black"
        }
        return (decrase:decrase,add:add)
    }
    
    func decraseButtonDisabled(guestId id : Int) -> Bool {
        let guest = guestList[id]
        let buttonDisabled : Bool
        if guest.title == "Advert" {
            if guest.piece == 1 {
                buttonDisabled = true
            }else{
                buttonDisabled = false
            }
        }else{
            if guest.piece == 0 {
                buttonDisabled = true
            }else{
                buttonDisabled = false
            }
        }
        return buttonDisabled
    }
    
    
    
    func changeisMapCountryListLoded() {
        self.isMapCountryListLoded = !self.isMapCountryListLoded
    }
    
    func changeisMapCountryListError() {
        self.isMapCountryListError = !self.isMapCountryListError
        print(isMapCountryListError)
    }
    
    func toSearchResultViewAction() {
        if totalGuest == 0 {
            print("Total Guest Error")
            // When I code my 3rd party framework the warning message will be added here
        }else{
            self.isToSearchResultView  = true
        }
    }
    
   


}


