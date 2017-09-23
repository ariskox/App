//
//  NumberFormItem.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

struct NumberFormItem<T>: FormItem {
    var value: Any? {
        get { return number }
        set { self.computeValid(newValue) }
    }
    
    var required: Bool = true {
        didSet {
            computeValid(value)
        }
    }
    
    private(set) var error: FormItemError? = .required
    private(set) var number: T?
    
    private var formatter: NumberFormatter
    
    init(value: T? = nil, required: Bool = true, formatter: NumberFormatter = NumberFormatter()) {
        self.formatter = formatter
        self.required = required
        self.computeValid(value)
    }
    
    private mutating func computeValid(_ aValue: Any?) {
        guard let aValue = aValue else {
            number = nil
            error = required ? .required : nil
            return
        }
        if let ourType = aValue as? T {
            number = ourType
        } else if let aString = aValue as? String {
            number = formatter.number(from: aString) as? T
        }
        error = number != nil ? nil : .invalidValue
    }
}
