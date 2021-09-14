//
//  ForwardApplication.swift
//  
//
//  Created by Martin Troup on 02.03.2021.
//

import Overture

infix operator |>: ForwardApplication

public func |> <A, B> (a: A, f: (A) throws -> B) rethrows -> B {
    try with(a, f)
}

