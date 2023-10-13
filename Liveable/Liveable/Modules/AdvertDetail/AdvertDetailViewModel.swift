//
//  AdvertDetailViewModel.swift
//  Liveable
//
//  Created by engin gülek on 3.10.2023.
//

import Foundation
import Alamofire
protocol AdvertDetailViewModelProtocol : ObservableObject {
    var iconSystemImage : String {get}
    var toEnterGuestInfo : Bool {get}
    
    func changeIconSystemImage(id:Int)
    func changeToEnterGuestInfo()
    
    
    
}

final class AdvertDetailViewModel : AdvertDetailViewModelProtocol {
    
    @Published var iconSystemImage: String = "heart"
    
    
    private let serviceManager : AdvertDetailViewServiceProtocol
    
    init(serviceManager: AdvertDetailViewServiceProtocol = AdvertDetailViewService.shared) {
        self.serviceManager = serviceManager
        self.getGuestList()
    }
    
    @Published var userInfo : UserInfo = UserInfo.defaultUserInfo
    @Published var advertCommentDic : Comment = [:]
    @Published var toEnterGuestInfo: Bool = false
    @Published var totalGuest : Int  = 0
    
    
    
    
    @Published var guestList : [GuestItem] = []
    private func getGuestList(){
         self.guestList = [
             GuestItem(id: 0, title: "Adult", subtitle: "13+",piece: 0),
             GuestItem(id: 1, title: "Kid", subtitle: "2-12",piece: 0),
             GuestItem(id: 2, title: "Baby", subtitle: "0-2",piece: 0)
             
         ]
     }
   
    private var savedList : AdvertDic = [:]
    func getUserInfo(userId id : Int) {
        serviceManager.fetchUserInfo(userId: id) { response in
            switch response {
            case .success(let user):
                DispatchQueue.main.async {
                    self.userInfo = user
                }
                
            case .failure(let failure):
                print("aLİ \(failure.localizedDescription)")
                self.userInfo = UserInfo.defaultUserInfo
            }
        }
    }
    
    func fetchAdvertComment(advertId:Int) {
        serviceManager.fetchAllComment(advertId:advertId) { result in
            switch result {
            case .success(let dic):
                DispatchQueue.main.async {
                    self.advertCommentDic = dic ?? [:]
                }
            case .failure(let failure):
                print("ARVM \(failure.localizedDescription)")
            }
        }
    }
    
    func fetchSavedList(id:Int) {
        serviceManager.fetchSavedList(userId: "userId") { result in
            switch result {
            case .success(let dic):
                DispatchQueue.main.async {
                    self.savedList = dic
                    self.changeIconSystemImage(id: id)
                }
            case .failure(let failure):
                print("ADVM \(failure.localizedDescription)")
            }
        }
    }
    

    
    
    
    func onTapHeartIcon(advert:Advert){
        self.fetchSavedList(id: advert.id)
        let filterSavedList = savedList.filter { $0.value.id == advert.id }
        
        if filterSavedList.isEmpty  {
            self.addAdvertToSavedList(advert: advert)
        }else{
            if let key = filterSavedList.keys.first {
                self.deleteAdvertToSavedList(id: advert.id, key: key)
            }
        }
        
    }
    
    
    
    
    private func addAdvertToSavedList(advert:Advert){
        serviceManager.addAdvertToSavedList(advert: advert.dictionary , userId: "userId") { resulr in
            switch resulr {
            case .success(_):
                self.fetchSavedList(id: advert.id)
            case .failure:
                print("error")
            }
        }
    }
    
    
    private func deleteAdvertToSavedList(id:Int,key:String){
        serviceManager.deleteAdvertFromSavedList(userId: "userId", key: key) { result in
            switch result {
            case .success:
                self.fetchSavedList(id: id)
            case .failure:
                self.fetchSavedList(id: id)
            }
        }
    }
}


extension AdvertDetailViewModel {
    func changeIconSystemImage(id:Int) {
        DispatchQueue.main.async {
            if self.savedList.contains(where: { $0.value.id == id }) {
                self.iconSystemImage = "heart.fill"
            }else{
                self.iconSystemImage = "heart"
            }
        }
    }
    
    func changeToEnterGuestInfo() {
        DispatchQueue.main.async {
            self.toEnterGuestInfo = !self.toEnterGuestInfo
        }
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
