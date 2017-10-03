//
//  FormItemProtocol.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation
import UIKit

protocol FormItemProtocol {
    var value: Any? { get set }
    var required: Bool { get }
    var error: FormItemError? { get }
}

extension FormItemProtocol {
    var isValid: Bool {
        return error == nil
    }
}

protocol FormItemValidator {
    associatedtype T
    init()
    func process(_ value: Any?, required: Bool) -> (T?, FormItemError?)
}

enum FormItemError: Error {
    case required
    case invalidValue
}
