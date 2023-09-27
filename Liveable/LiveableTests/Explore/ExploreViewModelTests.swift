//
//  ExploreViewModelTests.swift
//  LiveableTests
//
//  Created by engin gülek on 27.09.2023.
//

import XCTest
@testable import Liveable
final class ExploreViewModelTests: XCTestCase {

    private var exploreViewModel : ExploreViewModel!
    private var serviceManager : MockExploreService!
    override func setUp() {
        super.setUp()
        serviceManager = .init()
        exploreViewModel = ExploreViewModel(serviceManger: serviceManager)
        
    }

    override func tearDown() {
        super.tearDown()
        serviceManager = nil
        exploreViewModel =  nil
    }
  
    
    func test_fetchAdverts_ReturnSuccess_isPageLoadedTrue() {
       
        let advert = Advert(baseImageURL: "", category: "", decription: "", id: 0, images: [""], location: Location(city: "", country: "", latitude: "", longitude: ""), price: 0, rating: 1.0, roomCount: RoomCount(bath: 0, bed: 0, bedroom: 0, guest: 0), title: "", userID: 0)
        serviceManager.mockFetchAdvert = .success([advert])
        exploreViewModel.fetchAdvert()
        
        let expectation = expectation(description: "isPageLoadedTrue")
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.exploreViewModel.isPageLoaded)

            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 2.0)
    }
    
    
    func test_fetchAdverts_ReturnCustomError_isErrorTrueAndErrorMessage() {
        serviceManager.mockFetchAdvert = .failure(CustomError.networkError)
        exploreViewModel.fetchAdvert()
        let expectation = expectation(description: "isError")
        DispatchQueue.main.asyncAfter(deadline: .now()){
            XCTAssertTrue(self.exploreViewModel.isError)
            let message = self.exploreViewModel.errorMessage.message
            let icon = self.exploreViewModel.errorMessage.icon
            
            XCTAssertEqual(message,"Network Error")
            XCTAssertEqual(icon, "error")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 2.0)
    }
    
    
    func test_fetchAdverts_ReturnDefaultError_isErrorTrueAndErrorMessage() {
        serviceManager.mockFetchAdvert = .failure(CustomError.defaultError)
        exploreViewModel.fetchAdvert()
        let expectation = expectation(description: "isError")
        DispatchQueue.main.asyncAfter(deadline: .now()){
            XCTAssertTrue(self.exploreViewModel.isError)
            let message = self.exploreViewModel.errorMessage.message
            let icon = self.exploreViewModel.errorMessage.icon
            
            XCTAssertEqual(message,"something went wrong")
            XCTAssertEqual(icon, "error")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 2.0)
    }
}
