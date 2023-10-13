//
//  SearchResultViewModel.swift
//  Liveable
//
//  Created by engin gülek on 5.10.2023.
//

import Foundation
import Alamofire
protocol SearchResultViewModelProtocol : ObservableObject {
    var isPageLoaded: Bool { get }
    var isEmptyData :  Bool {get}
    
    func changeIsPageLoaded()
    func changeIsEmpty()
    
   
}


final class SearchResultViewModel : SearchResultViewModelProtocol  {
    
    @Published  var isPageLoaded: Bool = false
    @Published var isEmptyData: Bool = false
    @Published  var isError: Bool = false
    @Published var searchAdvertList : AdvertDic = [:]
    
    
    
    private let serviceManager : SearchResultServiceProtocol
   
    init(serviceManager: SearchResultServiceProtocol = SearchResultService.shared) {
        self.serviceManager = serviceManager
       
    }
    
    func searchAdvert(searchText : String) {
        if searchText.contains(","){
            let text =  searchText.split(separator: ",")[0]
            // Search by city
            self.searchByCity(text: String(text))
        }else{
            // Search by country
            self.searchByCountry(text: searchText)
          
        }
    }
    
    private func searchByCountry(text:String){
        print("VM 1 \(text)")
        serviceManager.searchByCountry(text: text) { result in
            switch result {
            case .success(let dic):
                self.changeIsPageLoaded()
                DispatchQueue.main.async {
                    self.searchAdvertList = dic 
                    if dic.isEmpty {
                        self.changeIsEmpty()
                        self.searchAdvertList = [:]
                    }
                }
               
            case .failure(let failure):
                self.changeIsPageLoaded()
                if failure.localizedDescription != "200" {
                    self.searchAdvertList = [:]
                }
            }
        }
        
    }
    
    private func searchByCity(text:String){
        serviceManager.searchByCity(text: text) { result in
            switch result {
            case .success(let dic):
                self.changeIsPageLoaded()
                DispatchQueue.main.async {
                    self.searchAdvertList = dic
                    if dic.isEmpty {
                        self.changeIsEmpty()
                        self.searchAdvertList = [:]
                    }
                    
                }
               
            case .failure(let failure):
                self.changeIsPageLoaded()
                if failure.localizedDescription != "200" {
                    self.searchAdvertList = [:]
                }
            }
        }
    }
    
    func calculatorPrice(advert:Advert,guestItms:[GuestItem]) -> (total:String,desc:String) {
        
        let advertPiece = guestItms.filter{$0.id == 0}[0].piece
        let kidPiece = guestItms.filter{$0.id == 1}[0].piece
        let babyPiece = guestItms.filter{$0.id == 2}[0].piece
        
        let desc = "\(advertPiece) Adult x \(advert.price.adult), \(kidPiece) Kid  x\(advert.price.kid), \(babyPiece) Baby x \(advert.price.baby)"
        
        let totalPrice = (advertPiece * advert.price.adult) +
        (kidPiece * advert.price.kid) +
        (babyPiece * advert.price.baby)
        return (total:"\(totalPrice)",desc:desc)
    }
}


extension SearchResultViewModel {
    func changeIsPageLoaded() {
        DispatchQueue.main.async {
            self.isPageLoaded = !self.isPageLoaded
        }
       
    }
    
    func changeIsEmpty() {
        DispatchQueue.main.async {
            self.isEmptyData = !self.isEmptyData
        }
        
    }
    
  
}
