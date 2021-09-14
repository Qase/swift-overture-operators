//
//  SingleTypeCompositionTests.swift
//  
//
//  Created by Martin Troup on 02.03.2021.
//

import XCTest
import OvertureOperators

final class SingleTypeCompositionTests: XCTestCase {
    func test_composition_of_2_operators() {
        XCTAssertEqual(3, (increment <> increment)(1))
    }

    func test_throwing_composition_of_2_operators() {
        XCTAssertEqual(3, try (nonThrowing(increment) <> increment)(1))
        XCTAssertThrowsError(try (throwing(increment) <> increment)(1))
    }

    func test_inout_composition_of_2_operators() {
        var value = 1
        (inoutIncrement <> inoutIncrement)(&value)
        XCTAssertEqual(3, value)
    }

    func test_inout_throwing_composition_of_2_operators() {
        var value = 1
        try? (nonThrowing(inoutIncrement) <> inoutIncrement)(&value)
        XCTAssertEqual(3, value)

        XCTAssertThrowsError(try (throwing(inoutIncrement) <> inoutIncrement)(&value))
    }

    func test_void_composition_of_2_operators() {
        var value = 1

        let inplaceIncrement: () -> Void = { value += 1 }

        (executeNonReturingClosure(inplaceIncrement) <> executeNonReturingClosure(inplaceIncrement))(EmptyClass())
        XCTAssertEqual(3, value)
    }

    func test_void_throwing_composition_of_2_operators() {
        var value = 1

        let inplaceIncrement: () -> Void = { value += 1 }

        let composedFunction = nonThrowing(executeNonReturingClosure(inplaceIncrement))
            <> executeNonReturingClosure(inplaceIncrement)

        try? composedFunction(EmptyClass())

        XCTAssertEqual(3, value)

        let throwingComposedFunction = throwing(executeNonReturingClosure(inplaceIncrement))
            <> executeNonReturingClosure(inplaceIncrement)

        XCTAssertThrowsError(try throwingComposedFunction(EmptyClass()))
    }

    func test_composition_of_3_operators() {
        XCTAssertEqual(4, (increment <> increment <> increment)(1))
    }

    func test_throwing_composition_of_3_operators() {
        XCTAssertEqual(4, try (nonThrowing(increment) <> nonThrowing(increment) >>> increment)(1))
        XCTAssertThrowsError(try (throwing(increment) <> throwing(increment) >>> increment)(1))
    }

    func test_inout_composition_of_3_operators() {
        var value = 1
        (inoutIncrement <> inoutIncrement <> inoutIncrement)(&value)
        XCTAssertEqual(4, value)
    }

    func test_inout_throwing_composition_of_3_operators() {
        var value = 1
        try? (nonThrowing(inoutIncrement) <> nonThrowing(inoutIncrement) <> inoutIncrement)(&value)
        XCTAssertEqual(4, value)

        XCTAssertThrowsError(try (throwing(inoutIncrement) <> throwing(inoutIncrement) <> inoutIncrement)(&value))
    }

    func test_void_composition_of_3_operators() {
        var value = 1

        let inplaceIncrement: () -> Void = { value += 1 }

        let composedFunction = executeNonReturingClosure(inplaceIncrement)
            <> executeNonReturingClosure(inplaceIncrement)
            <> executeNonReturingClosure(inplaceIncrement)

        composedFunction(EmptyClass())

        XCTAssertEqual(4, value)
    }

    func test_void_throwing_composition_of_3_operators() {
        var value = 1

        let inplaceIncrement: () -> Void = { value += 1 }

        let composedFunction = nonThrowing(executeNonReturingClosure(inplaceIncrement))
            <> executeNonReturingClosure(inplaceIncrement)
            <> executeNonReturingClosure(inplaceIncrement)

        try? composedFunction(EmptyClass())
        XCTAssertEqual(4, value)

        let throwingComposedFunction = throwing(executeNonReturingClosure(inplaceIncrement))
            <> executeNonReturingClosure(inplaceIncrement)
            <> executeNonReturingClosure(inplaceIncrement)

        XCTAssertThrowsError(try throwingComposedFunction(EmptyClass()))
    }

}

// MARK: - Helper functions

extension SingleTypeCompositionTests {
    private struct ExpectedError: Error {}

    private func throwing<A, B>(_: (A) -> B) -> (A) throws -> B {
        { _ in
            throw ExpectedError()
        }
    }

    private func throwing<A>(_: (inout A) -> Void) -> (inout A) throws -> Void {
        { _ in
            throw ExpectedError()
        }
    }

    private func nonThrowing<A, B>(_ f: @escaping (A) -> B) -> (A) throws -> B {
        f
    }

    private func nonThrowing<A>(_ f: @escaping (inout A) -> Void) -> (inout A) throws -> Void {
        f
    }

    private func increment(_ x: Int) -> Int {
        x + 1
    }

    private func inoutIncrement(_ x: inout Int) -> Void {
        x += 1
    }

    class EmptyClass {}

    private func executeNonReturingClosure(_ closure: @escaping () -> Void) -> (EmptyClass) -> Void {
        { value in
            closure()
        }
    }
}
