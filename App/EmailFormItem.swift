//
//  EmailFormItem.swift
//  App
//
//  Created by Aris Koxaras on 03/10/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

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
        (internalValue, error) = validator.process(aValue, required: required)
    }
}

struct EmailItemValidator: FormItemValidator {
    typealias T = String
    
    func process(_ value: Any?, required: Bool) -> (String?, FormItemError?) {
        guard let value = value else {
            return (nil, required ? .required : nil)
        }

        guard let str = value as? String,
            str.isEmail() else {
                return (nil, .invalidValue)
        }
        return (str, nil)
    }
}
