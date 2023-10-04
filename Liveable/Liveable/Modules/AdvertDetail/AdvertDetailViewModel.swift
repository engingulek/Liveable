//
//  AdvertDetailViewModel.swift
//  Liveable
//
//  Created by engin gülek on 3.10.2023.
//

import Foundation

protocol AdvertDetailViewModelProtocol : ObservableObject {}

final class AdvertDetailViewModel : AdvertDetailViewModelProtocol {
    
    private let serviceManager : AdvertDetailViewServiceProtocol
    
    init(serviceManager: AdvertDetailViewServiceProtocol = AdvertDetailViewService.shared) {
        self.serviceManager = serviceManager
    }
    
    @Published var userInfo : UserInfo = UserInfo.defaultUserInfo
    @Published var advertCommentDic : Comment = [:]
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
   
    
    
    
    
    
    
    
}
