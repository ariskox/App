//
//  FormItems.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

typealias TextFormItem = FormItem<TextItemValidator>
typealias EmailFormItem = FormItem<EmailItemValidator>
typealias NumberFormItem<T> = FormItem<NumberItemValidator<T, NumberFormatter>>

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
        guard let str = value as? String else { return .error(.invalidValue) }
        guard str.isEmail() else { return .error(.invalidEmail) }
        return .value(str)
    }
}

struct NumberItemValidator<T, F: NumberFormatter>: FormValidator {
    private let formatter = F()
    
    func process(_ value: Any) -> ValidatorResult<T> {
        if let ourType = value as? T {
            return .value(ourType)
        } else if let str = value as? String, let val = formatter.number(from: str) as? T {
            return .value(val)
        }
        return .error(.invalidValue)
    }
}

