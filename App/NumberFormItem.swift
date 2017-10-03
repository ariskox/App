//
//  NumberFormItem.swift
//  App
//
//  Created by Aris Koxaras on 03/10/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

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
        (internalValue, error) = validator.process(aValue, required: required)
    }
}

struct NumberItemValidator<T>: FormItemValidator {
    private let formatter: NumberFormatter
    
    init() {
        self.formatter = NumberFormatter()
    }
    
    init(formatter: NumberFormatter = NumberFormatter()) {
        self.formatter = formatter
    }
    
    func process(_ value: Any?, required: Bool) -> (T?, FormItemError?) {
        guard let value = value else {
            return (nil, required ? .required : nil)
        }

        if let ourType = value as? T {
            return (ourType, nil)
        } else if let str = value as? String, let val = formatter.number(from: str) as? T {
            return (val, nil)
        }
        return (nil, .invalidValue)
    }
}
