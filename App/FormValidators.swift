//
//  FormValidators.swift
//  App
//
//  Created by Aris Koxaras on 02/10/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

enum ValidatorResult<T> {
    case error(FormItemError)
    case value(T)
}

protocol FormValidator {
    associatedtype T
    init()
    func process(_ value: Any) -> ValidatorResult<T>
}

struct TextItemValidator: FormValidator {
    typealias T = String
    func process(_ value: Any) -> ValidatorResult<T> {
        guard let str = value as? String else { return .error(.invalidValue) }
        return .value(str)
    }
}

struct EmailItemValidator: FormValidator {
    typealias T = String
    func process(_ value: Any) -> ValidatorResult<T> {
        guard let str = value as? String,
            str.isEmail() else { return .error(.invalidValue) }
        return .value(str)
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
    
    func process(_ value: Any) -> ValidatorResult<T> {
        if let ourType = value as? T {
            return .value(ourType)
        } else if let str = value as? String, let val = formatter.number(from: str) as? T {
            return .value(val)
        }
        return .error(.invalidValue)
    }
}
