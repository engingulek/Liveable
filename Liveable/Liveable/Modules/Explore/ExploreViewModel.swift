//
//  ExploreViewModel.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation

protocol ExploreViewModelProtocol : ObservableObject {
    var isPageLoaded: Bool { get }
}


final class ExploreViewModel : ExploreViewModelProtocol  {
    var isPageLoaded: Bool = false
    
    private let serviceManger : ExploreServiceProtocol
    @Published var advertList : [Advert] = []
    
    init(serviceManger: ExploreServiceProtocol = ExploreService.shared) {
        self.serviceManger = serviceManger
        Task {
            await fetchAdvert()
        }
    }
    
    func fetchAdvert() async {
        let response = await serviceManger.fetchAdverts()
        switch response {
        case .success(let items):
            self.advertList = items ?? []
        case .failure(let failure):
            print(failure.localizedDescription)
        }
        self.isPageLoaded = true
    }
}
