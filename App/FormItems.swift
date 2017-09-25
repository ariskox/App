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


class ConcreteValidator<A>: FormValidator {
    typealias T = A
    required init() { }
    func process(_ value: Any) -> ValidatorResult<A> {
        fatalError()
    }
}

final class TextItemValidator: ConcreteValidator<String> {
    override func process(_ value: Any) -> ValidatorResult<T> {
        guard let str = value as? String else { return .error(.invalidValue) }
        return .value(str)
    }
}

final class EmailItemValidator: ConcreteValidator<String> {
    override func process(_ value: Any) -> ValidatorResult<T> {
        guard let str = value as? String,
            str.isEmail() else { return .error(.invalidValue) }
        return .value(str)
    }
}

final class NumberItemValidator<T, F: NumberFormatter>: ConcreteValidator<T> {
    private let formatter = F()
    
    override func process(_ value: Any) -> ValidatorResult<T> {
        if let ourType = value as? T {
            return .value(ourType)
        } else if let str = value as? String, let val = formatter.number(from: str) as? T {
            return .value(val)
        }
        return .error(.invalidValue)
    }
}

