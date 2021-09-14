//
//  EffectfulCompositionTests.swift
//
//
//  Created by Martin Troup on 02.03.2021.
//

import XCTest
import OvertureOperators

final class EffectfulCompositionTests: XCTestCase {
    func test_optional_composition_of_2_operators() {
        XCTAssertEqual(.some(3), (optIncrement >=> optIncrement)(1))
    }

    func test_optional_throwing_composition_of_2_operators() {
        XCTAssertEqual(.some(3), try (nonThrowing(optIncrement) >=> optIncrement)(1))
        XCTAssertThrowsError(try (throwing(optIncrement) >=> optIncrement)(1))
    }

    func test_array_composition_of_2_operators() {
        XCTAssertEqual([3], ( arrayIncrement >=> arrayIncrement)(1))
    }

    func test_array_throwing_composition_of_2_operators() {
        XCTAssertEqual([3], try (nonThrowing(arrayIncrement) >=> arrayIncrement)(1))
        XCTAssertThrowsError(try (throwing(arrayIncrement) >=> arrayIncrement)(1))
    }

    func test_optional_composition_of_3_operators() {
        XCTAssertEqual(.some(4), (optIncrement >=> optIncrement >=> optIncrement)(1))
    }

    func test_optional_throwing_composition_of_3_operators() {
        XCTAssertEqual(.some(4), try (nonThrowing(optIncrement) >=> nonThrowing(optIncrement) >=> optIncrement)(1))
        XCTAssertThrowsError(try (throwing(optIncrement) >=> throwing(optIncrement) >=> optIncrement)(1))
    }

    func test_array_composition_of_3_operators() {
        XCTAssertEqual([4], (arrayIncrement >=> arrayIncrement >=> arrayIncrement)(1))
    }

    func test_array_throwing_composition_of_3_operators() {
        XCTAssertEqual([4], try (nonThrowing(arrayIncrement) >=> nonThrowing(arrayIncrement) >=> arrayIncrement)(1))
        XCTAssertThrowsError(try (throwing(arrayIncrement) >=> throwing(arrayIncrement) >=> arrayIncrement)(1))
    }
}

// MARK: - Helper functions

extension EffectfulCompositionTests {
    private struct ExpectedError: Error {}
    private func throwing<A, B>(_: (A) -> B) -> (A) throws -> B {
        { _ in
            throw ExpectedError()
        }
    }

    private func nonThrowing<A, B>(_ f: @escaping (A) -> B) -> (A) throws -> B {
        return f
    }
    
    private func increment(_ x: Int) -> Int {
        x + 1
    }

    private func optIncrement(_ x: Int) -> Int? {
        .some(increment(x))
    }

    private func arrayIncrement(_ x: Int) -> [Int] {
        [increment(x)]
    }
}
