//
//  ExploreViewModel.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation

protocol ExploreViewModelProtocol : ObservableObject {
    var isPageLoaded: Bool { get }
    var isCategoryLoaded : Bool {get}
    var isEmptyData :  Bool {get}
    var isError : Bool {get}
    var errorMessage : (message:String,icon:String) {get}
    var defaultMessage : (message:String,icon:String) {get}
    var isToAdvertDetailView : Bool {get}
    var isToSearchView : Bool {get}
   
   

  
    
    func changeIsPageLoaded(isLoad:Bool)
    func changeIsEmpty()
    func changeIsError()
    func changeIsCategoryLoaded()
    func changeErrorMessage(message:String,icon:String)
    func changeDefaultMessage(message:String,icon:String)
    func filterAdvertWithCategory(categoryId id : Int)
    func changeToAdvertDetailView()
    func changeisToSearchView()
 
}


final class ExploreViewModel : ExploreViewModelProtocol  {
    
    
    
    
    
    @Published var errorMessage: (message: String, icon: String) = ("","")
    @Published var defaultMessage: (message: String, icon: String)  = ("dsa","")
    @Published var isEmptyData: Bool = false
    @Published var isPageLoaded: Bool = false
    @Published var isCategoryLoaded: Bool  = false
    @Published var isError: Bool = false
  
    @Published var categoryTab: Int = 0
    private let serviceManger : ExploreServiceProtocol
    @Published var advertList : [Advert] = []
    @Published var categoryList : [Category] = []
    @Published var searchText : String  = ""
    @Published var toSearh: Bool = false
   @Published var isToAdvertDetailView: Bool = false
   @Published var isToSearchView: Bool = false

    
 
  

    init(serviceManger: ExploreServiceProtocol = ExploreService.shared) {
        self.serviceManger = serviceManger
        fetchAdvert()
        fetchCategory()
    }
 
    func fetchAdvert() {
       serviceManger.fetchAdverts { result in
            switch result {
            case .success(let list):
                self.changeIsPageLoaded(isLoad: true)
                DispatchQueue.main.async {
                    self.advertList =  list ?? []
                }
                
            case .failure(let error):
                self.changeIsPageLoaded(isLoad: true)
                self.changeIsError()
                if error as! CustomError == CustomError.networkError {
                    self.changeErrorMessage(message: "Network Error", icon: "error")
                }else{
                    self.changeErrorMessage(message: "something went wrong", icon: "error")
                }
            }
          
        }
    }
    
    func fetchCategory(){
        
        serviceManger.fetchCategory { result in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self.categoryList = list ?? []
                }
            case .failure(let failure):
                if failure.localizedDescription != "200" {
                    self.categoryList =  []
                }
               
            }
            self.changeIsCategoryLoaded()
        }
    }
    
    func filterAdvertWithCategory(categoryId id : Int){
        self.changeIsPageLoaded(isLoad: false)
        if id == 0 {
            self.changeIsEmpty()
            fetchAdvert()
        }else{
            serviceManger.fetchAdvertFilter(categoryId: id) { result in
                switch result {
                case .success(let filterList):
                    self.changeIsPageLoaded(isLoad: true)
                    
                        guard let list = filterList else {return}
                        if list.isEmpty {
                            self.changeIsEmpty()
                            self.changeDefaultMessage(message: "Ad not found", icon: "no-data")
                        }
                    
                    DispatchQueue.main.async {
                        self.advertList = list
                    }
                  
                    
                case .failure(let failure):
                    if failure.localizedDescription != "200" {
                        self.categoryList =  []
                    }
                }
            }
        }
    }

    
}


extension ExploreViewModel {
    func changeIsPageLoaded(isLoad:Bool) {
        DispatchQueue.main.async {
            self.isPageLoaded = isLoad
        }
    }
    
    func changeIsCategoryLoaded() {
        DispatchQueue.main.async {
            self.isCategoryLoaded = !self.isCategoryLoaded
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
    
    func changeDefaultMessage(message: String, icon: String) {
        DispatchQueue.main.async {
            self.defaultMessage = (message:message,icon:icon)
        }
    }
    
    func changeToAdvertDetailView() {
        DispatchQueue.main.async {
            self.isToAdvertDetailView = !self.isToAdvertDetailView
        }
    }
    
    
    func changeisToSearchView() {
        self.isToSearchView = true
    }
    
    
  
    
}
