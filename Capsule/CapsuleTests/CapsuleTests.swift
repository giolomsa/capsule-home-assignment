//
//  CapsuleTests.swift
//  CapsuleTests
//
//  Created by Gio Lomsa on 10/20/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import XCTest
@testable import Capsule

class CapsuleTests: XCTestCase {

    private var viewModel: ListsViewModel!
    
    override func setUp() {
        
        viewModel = ListsViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func testMainListNetworkCall(){
        //Set expectation
        let expectation = XCTestExpectation(description: "load lists")
        //Make a network call
        viewModel.apiClient.getLists(completion: { (result) in
            switch result{
            case .failure(_):
                XCTAssert(false, "Error while loading lists")
            case .success(let lists):
                XCTAssert(!lists.isEmpty, "Lists array is empty")
            }
            expectation.fulfill()
        })
        //Wait for 10 seconds
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testListDetailsNetworkCall(){
        //Set expectation
        let expectation = XCTestExpectation(description: "load list's details")
        //Make a network call using mock data
        viewModel.apiClient.getListsDetails(date: "2011-02-13", list: "combined-print-and-e-book-fiction", completion: { (result) in
            switch result{
            case .failure(_):
                XCTAssert(false, "Error while loading list's details")
            case .success(let _):
                break
            }
            expectation.fulfill()
        })
        //Wait for 10 seconds
        wait(for: [expectation], timeout: 10.0)
    }

}
