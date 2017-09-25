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
        let item = TextFormItem(value: nil)
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
        let item = EmailFormItem(value: nil)
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
        let item = NumberFormItem<Double>()
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
        let item = NumberFormItem<Int>()

        item.value = "5"
        XCTAssertTrue(item.isValid)
        XCTAssertNil(item.error)
       
        item.value = "5.2"
        XCTAssertFalse(item.isValid)
        XCTAssertTrue(item.error == .invalidValue)
    }

    func testFormIsValid() {
        let textItem = TextFormItem(value: "aaaa", required: true)
        let emailItem = EmailFormItem(value: "correct@example.org", required: true)
        let numberItem = NumberFormItem<Int>(value: 5, required: true)
        let form = Form(items: [textItem, emailItem, numberItem] as! [FormItem<ConcreteValidator<AnyObject>>])
        XCTAssertTrue(form.isValid)
    }
//
//    func testFormIsInvalid() {
//        var form = Form(items: [TextFormItem(text: nil, required: true),
//                                EmailFormItem(email: nil, required: true),
//                                NumberFormItem<Double>(value: nil, required: true)])
//        XCTAssertFalse(form.isValid)
//
//        form.items[0].value = "fdsa"
//        XCTAssertFalse(form.isValid)
//
//        form.items[1].value = "fdsa"
//        XCTAssertFalse(form.isValid)
//
//        form.items[1].value = "fdsa"
//        XCTAssertFalse(form.isValid)
//
//        form.items[1].value = "correct@example.org"
//        XCTAssertFalse(form.isValid)
//
//        form.items[2].value = "5.2"
//        XCTAssertTrue(form.isValid)
//
//        form.items[2].value = "5"
//        XCTAssertTrue(form.isValid)
//    }
}
