//
//  SavedViewModel.swift
//  Liveable
//
//  Created by engin gülek on 12.10.2023.
//

import Foundation

protocol SavedViewModelProtocol : ObservableObject {
    var isLoadingPage : Bool {get}
    var isEmptyData :  Bool {get}
    var isError : Bool {get}
    var isMessage : (message:String,icon:String) {get}
    var toDetailView : Bool {get}
    
    func changeIsLoadingPage()
    func changeIsEmptyData()
    func changeIsError()
    func changeIsMessage(message:String,icon:String)
    func changeToDetailView()
    
    
}


final class SavedViewModel : SavedViewModelProtocol {
    
    
    
    
    @Published var isLoadingPage: Bool = false
    @Published var isEmptyData: Bool = false
    @Published var isError: Bool = false
    @Published var isMessage: (message: String, icon: String) = ("","")
    @Published var savedList: AdvertDic = [:]
    @Published var toDetailView: Bool = false
    
    private let serviceManager : SavedServiceProtocol
    
    init(serviceManager: SavedServiceProtocol = SavedService.shared) {
        self.serviceManager = serviceManager
        fetchSavedList()
    }
    
    
    func fetchSavedList(){
        serviceManager.fetchSavedList(userId: "userId") { result  in
            switch result {
            case .success(let dicList):
                self.changeIsLoadingPage()
                
                guard let list = dicList else {return}
                if list.isEmpty {
                    self.changeIsEmptyData()
                    self.changeIsMessage(message: "Ad not found", icon: "no-data")
                }
                
                DispatchQueue.main.async {
                    self.savedList = list
                }
                
            case .failure(let error):
                self.changeIsLoadingPage()
                self.changeIsError()
                if error as! CustomError == CustomError.networkError {
                    self.changeIsMessage(message: "Network Error", icon: "error")
                    
                }else{
                    self.changeIsMessage(message: "something went wrong", icon: "error")
                }
                
                
            }
        }
    }
    
    
    
    
}


extension SavedViewModel {
    
    func didLoad() {
        fetchSavedList()
    }
    
    func changeIsLoadingPage() {
        DispatchQueue.main.async {
            self.isLoadingPage = !self.isLoadingPage
        }
    }
    
    func changeIsEmptyData() {
        DispatchQueue.main.async {
            self.isEmptyData = !self.isEmptyData
        }
    }
    
    func changeIsMessage(message: String, icon: String) {
        DispatchQueue.main.async {
            self.isMessage = (message:message,icon:icon)
        }
    }
    
    
    func changeIsError() {
        DispatchQueue.main.async {
            self.isError = !self.isError
        }
    }
    
    
    func changeToDetailView() {
        self.toDetailView = !self.toDetailView
    }
    
    
    
    
}
