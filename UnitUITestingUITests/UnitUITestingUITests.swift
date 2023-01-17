//
//  UnitUITestingUITests.swift
//  UnitUITestingUITests
//
//  Created by Ogabek Matyakubov on 14/01/23.
//

import XCTest

final class UnitUITestingUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func testWithListExist() {
        app.launch()
        
        let ex = expectation(description: "testWithListExist")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                XCTAssertTrue(self.app.tables.element.exists)
                ex.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Error: \(error)")
            }
        }
        
    }
    
}
