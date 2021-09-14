//
//  EffectfulComposition.swift
//  
//
//  Created by Martin Troup on 02.03.2021.
//

import Overture

infix operator >=>: EffectfulComposition

// MARK: - Forward composition of functions that return `Optional`

public func >=> <A, B, C>(_ f: @escaping (A) -> B?, _ g: @escaping (B) -> C?) -> ((A) -> C?) {
    chain(f, g)
}

public func >=> <A, B, C>(_ f: @escaping (A) throws -> B?, _ g: @escaping (B) throws -> C?) -> ((A) throws -> C?) {
    chain(f, g)
}

// MARK: - Forward composition of functions that return `Array`

public func >=> <A, B, C>(_ f: @escaping (A) -> [B], _ g: @escaping (B) -> [C]) -> ((A) -> [C]) {
    chain(f, g)
}

public func >=> <A, B, C>(_ f: @escaping (A) throws -> [B], _ g: @escaping (B) throws -> [C]) -> ((A) throws -> [C]) {
    chain(f, g)
}
