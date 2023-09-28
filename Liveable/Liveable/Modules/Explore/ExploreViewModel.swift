//
//  ExploreViewModel.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation

protocol ExploreViewModelProtocol : ObservableObject {
    var isPageLoaded: Bool { get }
    var isEmptyData :  Bool {get}
    var isError : Bool {get}
    var errorMessage : (message:String,icon:String) {get}
   

  
    
    func changeIsPageLoaded()
    func changeIsEmpty()
    func changeIsError()
    func changeErrorMessage(message:String,icon:String)
 
}


final class ExploreViewModel : ExploreViewModelProtocol  {
    
    
    @Published var errorMessage: (message: String, icon: String) = ("","")
    @Published var isEmptyData: Bool = false
    @Published var isPageLoaded: Bool = false
    @Published var isError: Bool = false
  
    @Published var categoryTab: Int = 0
    private let serviceManger : ExploreServiceProtocol
    @Published var advertList : [Advert] = []
    @Published var searchText : String  = ""
    
    @Published var toSearh: Bool = false

 
  

    init(serviceManger: ExploreServiceProtocol = ExploreService.shared) {
        self.serviceManger = serviceManger
        fetchAdvert()
        
    }
    
    
    

    
    
    
    func fetchAdvert() {
       serviceManger.fetchAdverts { result in
            switch result {
            case .success(let list):
                self.changeIsPageLoaded()
                DispatchQueue.main.async {
                    self.advertList =  list ?? []
                }
                
            case .failure(let error):
                self.changeIsPageLoaded()
                self.changeIsError()
                if error as! CustomError == CustomError.networkError {
                    self.changeErrorMessage(message: "Network Error", icon: "error")
                }else{
                    self.changeErrorMessage(message: "something went wrong", icon: "error")
                }
            }
          
        }
       
    }
}


extension ExploreViewModel {
    func changeIsPageLoaded() {
        DispatchQueue.main.async {
            self.isPageLoaded = !self.isPageLoaded
        }
    }
    func changeIsEmpty(){
        DispatchQueue.main.async {  [weak self] in
            guard let self = self else {return}
            self.isEmptyData = !self.isEmptyData
        }
    }
    func changeIsError(){
        DispatchQueue.main.async {
            self.isError = !self.isError
        }
    }
    func changeErrorMessage(message:String,icon:String){
        DispatchQueue.main.async {
            self.errorMessage = (message:message,icon:icon)
        }
    }
    
  
    
}
