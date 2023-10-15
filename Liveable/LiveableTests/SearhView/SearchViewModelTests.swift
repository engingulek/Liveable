
import XCTest
@testable import Liveable
final class SearhViewModelTests : XCTestCase {
    private var viewModel : SearhViewModel!
    private var serviceManager : MockSearchService!
    
    override func setUp() {
        super.setUp()
        serviceManager = .init()
        viewModel = SearhViewModel(serviceManager: serviceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        serviceManager = nil
        viewModel = nil
    }
    
    func test_fetchMapCountryList_ResturnSuccess_isMapCountryListLodedTrue(){
        XCTAssertFalse(self.viewModel.isMapCountryListLoded)
        let country = MapCountryElement(id: 0, imageURL: "Example Url", title: "Example Title")
        serviceManager.mockFetchMapCountryList = .success([country])
        viewModel.didLoad()
        
        let expectation = expectation(description: "isMapCountryListLoded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.viewModel.isMapCountryListLoded)
            expectation.fulfill()
        }
        
        wait(for: [expectation],timeout: 2.0)
    }
    
    func test_fetchMapCountryList_ResturnCustomErrorNetwork_isMapCountryListErrorTrue(){
        XCTAssertFalse(self.viewModel.isMapCountryListLoded)
        serviceManager.mockFetchMapCountryList = .failure(CustomError.networkError)
        viewModel.didLoad()
        
        let expectation = expectation(description: "isMapCountryListError")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.viewModel.isMapCountryListError)
            let message = self.viewModel.isMapCountryListErrorMessage
            
            XCTAssertEqual(message,"Network Error")
            expectation.fulfill()
        }
        
        wait(for: [expectation],timeout: 2.0)
    }
    
    func test_fetchMapCountryList_ResturnCustomErrorDefault_isMapCountryListErrorTrue(){
        
        XCTAssertFalse(self.viewModel.isMapCountryListLoded)
        serviceManager.mockFetchMapCountryList = .failure(CustomError.defaultError)
        
        viewModel.didLoad()
        
        let expectation = expectation(description: "isMapCountryListError")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.viewModel.isMapCountryListError)
            let message = self.viewModel.isMapCountryListErrorMessage
            
            XCTAssertEqual(message,"Something Went Wrong")
            expectation.fulfill()
        }
        
        wait(for: [expectation],timeout: 2.0)
    }
    
    
    func test_searhAction_ReturnTrue() {
        viewModel.searchText = "Ista"
        XCTAssertTrue(viewModel.searhAction)
    }
    
    func test_searchCity_ReturnError_cityListEmpty() {
        serviceManager.mockFetchCityList = .failure(CustomError.networkError)
        
        let expectation = expectation(description: "searhCity")
       
        viewModel.searchText = "Ista"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.viewModel.cityList.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 2.0)
    }
    
    func test_IfTotalGuestZero_onTapSearhButton_ReturnyIsGuestEmptyError_True(){
        
        viewModel.toSearchResultViewAction()
        XCTAssertTrue(viewModel.isGuestEmptyError)
        XCTAssertEqual(viewModel.totalGuest,0)
        XCTAssertEqual(viewModel.isGuestEmptyErrorMessage.0,"Error")
        XCTAssertEqual(viewModel.isGuestEmptyErrorMessage.1,"Please Enter Guest")
    }
    
    func test_addGuest_TotalGuest_Retrun3(){
        viewModel.addGuest(guestId: 0)
        viewModel.addGuest(guestId: 1)
        viewModel.addGuest(guestId: 1)
        
        XCTAssertEqual(viewModel.totalGuest,3)
        
    }
    
    
    func test_addGuest_TotalGuest_Retrun4(){
        
        viewModel.addGuest(guestId: 0)
        viewModel.addGuest(guestId: 1)
        viewModel.addGuest(guestId: 2)
        
        viewModel.decreaseGuest(guestId: 1)
        
        XCTAssertEqual(viewModel.totalGuest,2)
        
    }
    
    func test_addAndDecraseButtonColor_GrayAndBlack(){
       let item = viewModel.addAndDecraseButtonColot(piece: 0)
        XCTAssertEqual(item.decrase,"gray")
        XCTAssertEqual(item.add,"black")
        
    }
    
    func test_addAndDecraseButtonColor_BlackAndBlack(){
       let item = viewModel.addAndDecraseButtonColot(piece: 2)
        XCTAssertEqual(item.decrase,"black")
        XCTAssertEqual(item.add,"black")
        
    }
    
    func test_onTapPlaceView_viewStaus_ReturnTrue(){
        self.viewModel.onTapPlaceView()
        XCTAssertTrue(viewModel.viewStatus)
        
        
    }
    
    func test_onTapGuestView_viewStaus_ReturnFalse(){
        self.viewModel.viewStatus = false
        self.viewModel.onTapGuestView()
        XCTAssertFalse(viewModel.viewStatus)
    }
}

