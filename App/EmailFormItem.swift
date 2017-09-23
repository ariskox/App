//
//  EmailFormItem.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

struct EmailFormItem: FormItem {
    var value: Any? {
        get { return email }
        set { self.email = newValue as? String }
    }
    
    var email: String? {
        didSet {
            computeValid()
        }
    }
    var required: Bool = true {
        didSet {
            computeValid()
        }
    }
    private(set) var error: FormItemError? = .required
    
    init(email: String? = nil, required: Bool = true) {
        self.required = required
        self.email = email
         computeValid()
    }
    
    private mutating func computeValid() {
        guard let email = email else {
            error = required ? .required : nil
            return
        }
        error = email.isEmail() ? nil : .invalidEmail
    }
}
