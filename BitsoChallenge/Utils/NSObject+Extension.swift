//
//  NSObject+Extension.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/13/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
