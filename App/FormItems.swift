//
//  FormItems.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

struct TextFormItem: FormItemProtocol {
    var value: Any? {
        get { return internalValue }
        set { self.computeValid(newValue) }
    }
    private(set) var required: Bool = true
    private(set) var error: FormItemError? = .required
    private var internalValue: String?
    private var validator = TextItemValidator()
    
    init(value: String? = nil, required: Bool = true) {
        self.required = required
        self.computeValid(value)
    }
    
    private mutating func computeValid(_ aValue: Any?) {
        guard let aValue = aValue else {
            internalValue = nil
            error = required ? .required : nil
            return
        }
        (internalValue, error) = validator.process(aValue)
    }
}

struct EmailFormItem: FormItemProtocol {
    var value: Any? {
        get { return internalValue }
        set { self.computeValid(newValue) }
    }
    private(set) var required: Bool = true
    
    private(set) var error: FormItemError? = .required
    private var internalValue: String?
    private var validator = EmailItemValidator()
    
    init(value: String? = nil, required: Bool = true) {
        self.required = required
        self.computeValid(value)
    }
    
    private mutating func computeValid(_ aValue: Any?) {
        guard let aValue = aValue else {
            internalValue = nil
            error = required ? .required : nil
            return
        }
        
        (internalValue, error) = validator.process(aValue)
    }
}

struct NumberFormItem<T>: FormItemProtocol {
    var value: Any? {
        get { return internalValue }
        set { self.computeValid(newValue) }
    }

    private(set) var required: Bool = true
    private(set) var error: FormItemError? = .required
    private var internalValue: T?
    private var validator = NumberItemValidator<T>()
    
    init(value: T? = nil, required: Bool = true) {
        self.required = required
        self.computeValid(value)
    }
    
    private mutating func computeValid(_ aValue: Any?) {
        guard let aValue = aValue else {
            internalValue = nil
            error = required ? .required : nil
            return
        }
        (internalValue, error) = validator.process(aValue)
    }
}
