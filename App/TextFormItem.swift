//
//  TextFormItem.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

struct TextFormItem: FormItem {
    var value: Any? {
        get { return text }
        set { self.text = newValue as? String }
    }
    var required: Bool = true {
        didSet {
            computeValid()
        }
    }
    private(set) var error: FormItemError? = .required
    
    private var text: String? {
        didSet {
            computeValid()
        }
    }
    
    init(text: String? = nil, required: Bool = true) {
        self.required = required
        self.text = text
        computeValid()
    }
    
    private mutating func computeValid() {
        guard required else {
            error = nil
            return
        }
        let hasText = text != nil
        error = hasText ? nil : .required
    }
}
