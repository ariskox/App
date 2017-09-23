//
//  FormItem.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation
import UIKit

enum ValidatorResult<T> {
    case error(FormItemError)
    case value(T)
}

protocol FormValidator {
    associatedtype T
    init()
    func process(_ value: Any) -> ValidatorResult<T>
}


struct FormItem<Validator: FormValidator> {
    var value: Any? {
        get { return internalValue }
        set { self.computeValid(newValue) }
    }
    
    var required: Bool = true {
        didSet {
            computeValid(value)
        }
    }
    
    private(set) var error: FormItemError? = .required
    private(set) var internalValue: Validator.T?
    private var validator = Validator()

    init(value: Validator.T? = nil, required: Bool = true) {
        self.required = required
        self.computeValid(value)
    }
    
    private mutating func computeValid(_ aValue: Any?) {
        guard let aValue = aValue else {
            internalValue = nil
            error = required ? .required : nil
            return
        }
        
        switch validator.process(aValue) {
        case .error(let error):
            internalValue = nil
            self.error = error
        case .value(let value):
            self.internalValue = value
            self.error = nil
        }
    }
}

extension FormItem {
    var isValid: Bool {
        return error == nil
    }
}

