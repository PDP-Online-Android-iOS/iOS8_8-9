//
//  UnitUITestingTests.swift
//  UnitUITestingTests
//
//  Created by Ogabek Matyakubov on 14/01/23.
//

import XCTest
@testable import UnitUITesting

final class UnitUITestingTests: XCTestCase {

    func testContactListApiResponseNil() {
        
        let ex = expectation(description: "testContactListApiResponseNil")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
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
    
    func testContactDeleteApiResponseIs404() {
        
        let ex = expectation(description: "testContactDeleteApiResponseIs404")
        
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + "1", params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                ex.fulfill()
            case .failure(let error):
                XCTAssertEqual(error.responseCode, 404)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Error: \(error)")
            }
        }
        
    }
    
    func testContactCreateApiResponseDone() {
        let ex = expectation(description: "testContactCreateApiResponseDone")
        
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsPostCreate(contact: Contact(id: "", name: "1", number: "1")), handler: { response in
            switch response.result {
            case .success:
                let contact = try! JSONDecoder().decode(Contact.self, from: response.data!)
                XCTAssertEqual(contact.name, "1")
                ex.fulfill()
            case .failure(let error):
                print(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Error: \(error)")
            }
        }
        
    }
    
    func testContactEditApiResponseDone() {
        let ex = expectation(description: "testContactEditApiResponseDone")
        
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + "6", params: AFHttp.paramsPostUpdate(contact: Contact(id: "", name: "2", number: "2")), handler: { response in
            switch response.result {
            case .success:
                let contact = try! JSONDecoder().decode(Contact.self, from: response.data!)
                XCTAssertEqual(contact.name, "2")
                ex.fulfill()
            case .failure(let error):
                XCTAssertEqual(error.responseCode, 404)
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
