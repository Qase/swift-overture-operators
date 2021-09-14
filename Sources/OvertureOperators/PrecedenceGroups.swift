//
//  PrecedenceGroups.swift
//  
//
//  Created by Martin Troup on 02.03.2021.
//

import Foundation

precedencegroup ForwardApplication {
    associativity: left
    higherThan: AssignmentPrecedence
}

precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
}

precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: EffectfulComposition
}

precedencegroup Composition {
    associativity: left
    higherThan: SingleTypeComposition
}
