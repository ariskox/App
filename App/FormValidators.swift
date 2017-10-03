//
//  FormValidators.swift
//  App
//
//  Created by Aris Koxaras on 02/10/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

protocol FormValidator {
    associatedtype T
    init()
    func process(_ value: Any?) -> (T?, FormItemError?)
}

enum FormItemError: Error {
    case required
    case invalidValue
}

struct TextItemValidator: FormValidator {
    typealias T = String
    func process(_ value: Any?) -> (String?, FormItemError?) {
        guard let str = value as? String else {
            return (nil, .invalidValue)
        }
        return (str, nil)
    }
}

struct EmailItemValidator: FormValidator {
    typealias T = String
    func process(_ value: Any?) -> (String?, FormItemError?) {
        guard let str = value as? String,
            str.isEmail() else {
                return (nil, .invalidValue)
        }
        return (str, nil)
    }
}

struct NumberItemValidator<T>: FormValidator {
    private let formatter: NumberFormatter

    init() {
        self.formatter = NumberFormatter()
    }
    
    init(formatter: NumberFormatter = NumberFormatter()) {
        self.formatter = formatter
    }
    
    func process(_ value: Any?) -> (T?, FormItemError?) {
        if let ourType = value as? T {
            return (ourType, nil)
        } else if let str = value as? String, let val = formatter.number(from: str) as? T {
            return (val, nil)
        }
        return (nil, .invalidValue)
    }
}
