//
//  Form.swift
//  App
//
//  Created by Aris Koxaras on 23/09/2017.
//  Copyright © 2017 App. All rights reserved.
//

import Foundation

struct Form {
    public var items: [FormItem]
    
    init(items: [FormItem]) {
        self.items = items
    }
}

extension Form {
    var isValid: Bool {
        return !items.map { $0.isValid }.contains(false)
    }
    
    var getErrors: [FormItemError] {
        return items.flatMap{ $0.error }
    }
}
