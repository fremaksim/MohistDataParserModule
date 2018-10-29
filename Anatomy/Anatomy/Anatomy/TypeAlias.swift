//
//  TypeAlias.swift
//  MohistParser
//
//  Created by mozhe on 2018/10/23.
//  Copyright © 2018 mozhe. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: AnyObject]
//typealias JSONDict = [String: Any]

public func doInBackgound(block: @escaping ()->() ){
    DispatchQueue.global(qos: .default).async {
        block()
    }
}

public func doInMain(block: @escaping ()->() ){
    DispatchQueue.main.async {
        block()
    }
}
