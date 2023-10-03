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
       
        let advert = Advert(baseImageURL: "", category: 1, decription: "", id: 0, images: [""], location: Location(city: "", country: "", latitude: "", longitude: ""), price: 0, rating: 1.0, roomCount: RoomCount(bath: 0, bed: 0, bedroom: 0, guest: 0), title: "", userID: 0)
        serviceManager.mockFetchAdvert = .success([advert])
        exploreViewModel.fetchAdvert()
        
        let expectation = expectation(description: "isPageLoadedTrue")
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.exploreViewModel.isPageLoaded)

            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 2.0)
    }
    
    func test_fetchAdvertFilter_ReturnEmptyData(){
       
        serviceManager.mockFetchAdvertFilter = .success([])
        exploreViewModel.filterAdvertWithCategory(categoryId: 1)
        
        let expectation = expectation(description: "isEmptyData")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertEqual(self.exploreViewModel.defaultMessage.message, "Ad not found")
            XCTAssertEqual(self.exploreViewModel.defaultMessage.icon, "no-data")
        
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 2.0)
        
        
    }
    
    func test_fetchCategory_ReturnSuccess_isCategoryPageLoadedTrue() {
       
        let category = Category(id: 0, imageURL: "https://firebasestorage.googleapis.com/v0/b/liveable-c0c2d.appspot.com/o/category%2Fboat.png?alt=media&token=35c48068-ce7d-46e1-9499-e071e0ba3e24&_gl=1*u94pvm*_ga*MTM0OTAxODY1Mi4xNjc4NzIyNDQ3*_ga_CW55HF8NVT*MTY5NjI1MjU2MC42My4xLjE2OTYyNTQ2NzIuNy4wLjA.", name: "boat")
        serviceManager.mockFetchCategory = .success([category])
        exploreViewModel.fetchCategory()
        
        let expectation = expectation(description: "isCategoryLoaded")
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.exploreViewModel.isCategoryLoaded)

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
