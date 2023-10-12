//
//  AdvertDetailViewModel.swift
//  Liveable
//
//  Created by engin gülek on 3.10.2023.
//

import Foundation

protocol AdvertDetailViewModelProtocol : ObservableObject {
    var iconSystemImage : String {get}
    
    func changeIconSystemImage(id:Int)
    
}

final class AdvertDetailViewModel : AdvertDetailViewModelProtocol {
    
    
    @Published var iconSystemImage: String = "heart"
    
    
    private let serviceManager : AdvertDetailViewServiceProtocol
    
    init(serviceManager: AdvertDetailViewServiceProtocol = AdvertDetailViewService.shared) {
        self.serviceManager = serviceManager
    }
    
    @Published var userInfo : UserInfo = UserInfo.defaultUserInfo
    @Published var advertCommentDic : Comment = [:]
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
}
