//
//  AppTests.swift
//  AppTests
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import XCTest
@testable import App

class AppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTextFormItem() {
        var item = TextFormItem(value: nil)
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .required)

        item.value = "a test"
        XCTAssertTrue(item.isValid)
        XCTAssertNil(item.error)

        item.value = nil
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .required)
    }
    
    func testEmailFormItem() {
        var item = EmailFormItem(value: nil)
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .required)
        
        item.value = "test@example.org"
        XCTAssertTrue(item.isValid)
        XCTAssertNil(item.error)
        
        item.value = "a test"
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .invalidValue)
    }
    
    func testNumberFormItem() {
        var item = NumberFormItem<Double>()
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .required)
        
        item.value = "test@example.org"
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .invalidValue)

        item.value = "5"
        XCTAssertTrue(item.isValid)
        XCTAssertNil(item.error)

        item.value = "5.0"
        XCTAssertTrue(item.isValid)
        XCTAssertNil(item.error)

        item.value = "5."
        XCTAssertTrue(item.isValid)
        XCTAssertNil(item.error)

        item.value = nil
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .required)
    }
    
    func testIntegerNumberFormItem() {
        var item = NumberFormItem<Int>()

        item.value = "5"
        XCTAssertTrue(item.isValid)
        XCTAssertNil(item.error)
       
        item.value = "5.2"
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .invalidValue)
    }

    func testFormIsValid() {
        let form = Form(items: [TextFormItem(value: "aaaa", required: true),
                                EmailFormItem(value: "correct@example.org", required: true),
                                NumberFormItem<Int>(value: 5, required: true)])
        XCTAssertTrue(form.isValid)
    }

    func testFormIsInvalid() {
        let form = Form(items: [TextFormItem(value: nil, required: true),
                                EmailFormItem(value: nil, required: true),
                                NumberFormItem<Double>(value: nil, required: true)])
        XCTAssertFalse(form.isValid)

        form.items[0].value = "fdsa"
        XCTAssertFalse(form.isValid)

        form.items[1].value = "fdsa"
        XCTAssertFalse(form.isValid)

        form.items[1].value = "fdsa"
        XCTAssertFalse(form.isValid)

        form.items[1].value = "correct@example.org"
        XCTAssertFalse(form.isValid)

        form.items[2].value = "5.2"
        XCTAssertTrue(form.isValid)

        form.items[2].value = "5"
        XCTAssertTrue(form.isValid)
    }
}
