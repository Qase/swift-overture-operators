//
//  KeyPaths.swift
//  
//
//  Created by Martin Troup on 02.03.2021.
//

import Overture

prefix operator ^

public prefix func ^ <Root, Value>(kp: KeyPath<Root, Value>) -> (Root) -> Value {
    get(kp)
}

public prefix func ^ <Root, Value>(kp: WritableKeyPath<Root, Value>) -> (@escaping (Value) -> Value) -> (Root) -> Root {
    prop(kp)
}

