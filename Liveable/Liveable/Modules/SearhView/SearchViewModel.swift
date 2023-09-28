//
//  SearchViewModel.swift
//  Liveable
//
//  Created by engin gülek on 28.09.2023.
//

import Foundation


protocol SearchViewModelProtocol : ObservableObject {
    var placeStatus : Bool {get}
    var guestStatus : Bool {get}
    var searhAction : Bool {get}
    var isExitSearchList : Bool {get}
    
    func selectedLocation(text:String)
    func placeAction()
    func guestAction()
    
    
}

final class SearhViewModel :  SearchViewModelProtocol  {

    
    @Published var searchText : String = ""
    @Published var isExitSearchList : Bool = false
    
    
    @Published var placeStatus : Bool = true
    @Published var guestStatus : Bool = false
    var searhAction : Bool {
        if searchText.count >= 3 {
            return true
        }else{
            return false
        }
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
    

    
  

}


