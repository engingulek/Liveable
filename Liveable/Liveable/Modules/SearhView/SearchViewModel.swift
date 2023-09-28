//
//  SearchViewModel.swift
//  Liveable
//
//  Created by engin gülek on 28.09.2023.
//

import Foundation


protocol SearchViewModelProtocol : ObservableObject {
    var searhAction : Bool {get}
}

final class SearhViewModel :  SearchViewModelProtocol  {
    @Published var searchText : String = ""
    
    var searhAction : Bool {
        if searchText.count >= 3 {
            return true
        }else{
            return false
        }
    }

    
  

}


