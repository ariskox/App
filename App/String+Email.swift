//
//  String+Email.swift
//  Swift Kit
//
//  Created by Aris Koxaras on 22/10/16.
//  Copyright © 2016 Aris Koxaras. All rights reserved.
//

import Foundation

extension String {
    
    /**
     Checks whether the string is a valid email
     
     - Parameter extended: Set to true to check for all valid IANA TLDs, else only a handful of domains are checked
     
     - Returns: True if is a valid email, false otherwise
     */

    func isEmail(extended: Bool = false) -> Bool {
        let range = NSMakeRange(0, self.characters.count)
        let emailRegex = "[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}"
        
        guard let regExp = try? NSRegularExpression(pattern: emailRegex, options: []) else {
            return false
        }
        
        guard regExp.numberOfMatches(in: self, options: [], range: range) == 1 else {
            return false
        }
        let lowerCased = self.lowercased()
        
        guard let tldRange = lowerCased.range(of: ".", options: [.backwards], range: nil, locale: nil) else {
            return false
        }
        
        // Check if TLD is contained in valid TLDs
        let tldArray = extended ? domainTLDsEXT : domainTLDs
        return tldArray.contains(lowerCased.substring(from: tldRange.lowerBound))
    }

}
