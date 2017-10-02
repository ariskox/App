//
//  FormItem.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation
import UIKit

protocol FormItem {
    var value: Any? { get set }
    var required: Bool { get }
    var error: FormItemError? { get }
}

extension FormItem {
    var isValid: Bool {
        return error == nil
    }
}
