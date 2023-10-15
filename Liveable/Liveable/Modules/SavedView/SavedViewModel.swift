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
    
    func changeIsLoadingPage(isLoad:Bool)
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
                self.changeIsLoadingPage(isLoad: true)
                
                guard let list = dicList else {return}
                DispatchQueue.main.async {
                    self.savedList = list
                }
                if list.isEmpty  {
                    self.changeIsEmptyData()
                    self.changeIsMessage(message: "Ad not found", icon: "no-data")
                }
                
               
                
            case .failure(let error):
                self.changeIsLoadingPage(isLoad: true)
                self.changeIsError()
                if error as! CustomError == CustomError.networkError {
                    self.changeIsMessage(message: "Network Error", icon: "error")
                    
                }else{
                    self.changeIsMessage(message: "something went wrong", icon: "error")
                }
            }
        }
    }
    
    
    func onTapDeleteButton(advert:Advert) {
        let filterSavedList = savedList.filter { $0.value.id == advert.id }
        if let key = filterSavedList.keys.first {
            self.deleteAdvertFromSaved(key: key)
        }
        
    }
    
    private func deleteAdvertFromSaved(key:String){
        serviceManager.deleteAdvertFromSavedList(userId: "userId", key: key) { result in
            switch result {
            case .success:
                self.fetchSavedList()
            case .failure:
                self.fetchSavedList()
            }
        }
    }
}


extension SavedViewModel {

    
    func changeIsLoadingPage(isLoad:Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.isLoadingPage = isLoad
        }
    }
    
    func changeIsEmptyData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.isEmptyData = !self.isEmptyData
        }
    }
    
    func changeIsMessage(message: String, icon: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.isMessage = (message:message,icon:icon)
        }
    }
    
    
    func changeIsError() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.isError = !self.isError
        }
    }
    
    
    func changeToDetailView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            
            self.toDetailView = !self.toDetailView
        }
        
    }
    
    
    
    
}
