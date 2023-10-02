//
//  SearchViewModel.swift
//  Liveable
//
//  Created by engin gülek on 28.09.2023.
//

import Foundation


 struct GuestItem {
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
    
    func selectedLocation(text:String)
    func placeAction()
    func guestAction()
    func addGuest(guestId id : Int)
    func  decreaseGuest(guestId id: Int)
    func decraseButtonDisabled(guestId id : Int) -> Bool
  
    
    
}

final class SearhViewModel :  SearchViewModelProtocol  {
 
    
    @Published var searchText : String = ""
    @Published var isExitSearchList : Bool = false
    @Published var placeStatus : Bool = true
    @Published var guestStatus : Bool = false
    @Published var guestList : [GuestItem] = []
    @Published var totalGuest : Int  = 0
    
    
    init(){
        self.getGuestList()
    }
    
    var searhAction : Bool {
        if searchText.count >= 3 {
            return true
        }else{
            return false
        }
    }
    
    
    private func getGuestList(){
         self.guestList = [
             GuestItem(id: 0, title: "Adults", subtitle: "13+",piece: 0),
             GuestItem(id: 1, title: "Kids", subtitle: "2-12",piece: 0),
             GuestItem(id: 2, title: "Babay", subtitle: "0-2",piece: 0)
             
         ]
     }
   
    
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

}


