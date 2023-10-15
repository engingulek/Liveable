
import XCTest
@testable import Liveable

final class SearhResultViewModelTests :  XCTestCase {
    private var viewModel : SearchResultViewModel!
    private var serviceManager : MockSearchResultService!
    
    override func setUp() {
        super.setUp()
        serviceManager = .init()
        viewModel = .init(serviceManager: serviceManager)
    }
    
    override func tearDown() {
        serviceManager = nil
        viewModel = nil
    }
    
    func test_searchAdvert_searchByCity_isEmpty_ReturnTrue(){
        XCTAssertFalse(viewModel.isPageLoaded)
       
        serviceManager.mockSearchByCity = .success([:])
        viewModel.searchAdvert(searchText: "Istanbul,Turkey")
        let expectation = expectation(description: "isEmpty")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.viewModel.isEmptyData)
            XCTAssertTrue(self.viewModel.isPageLoaded)
            expectation.fulfill()
        }
        
        wait(for: [expectation],timeout: 2.0)

    }
    
    func test_searchAdvert_searchByCountry_isEmpty_ReturnTrue(){
        XCTAssertFalse(viewModel.isPageLoaded)
       
        serviceManager.mockSearchByCountry = .success([:])
        viewModel.searchAdvert(searchText: "Turkey")
        let expectation = expectation(description: "isEmpty")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            XCTAssertTrue(self.viewModel.isEmptyData)
            XCTAssertTrue(self.viewModel.isPageLoaded)
            expectation.fulfill()
        }
        
        wait(for: [expectation],timeout: 2.0)
    }
    
}
