//
//  AllReviewViewModel.swift
//  Liveable
//
//  Created by engin gülek on 4.10.2023.
//

import Foundation

protocol AllReviewViewModelProtocol : ObservableObject {
    
}


final class AllReviewViewModel :AllReviewViewModelProtocol {
    private let serviceManager : AllReviewServiceProtocol
  
    init(serviceManager: AllReviewServiceProtocol = AllReviewService.shared) {
        self.serviceManager = serviceManager
        
    }
    
    @Published var advertCommentDic : Comment = [:]
    
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
