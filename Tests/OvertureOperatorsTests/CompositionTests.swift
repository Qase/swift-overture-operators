//
//  CompositionTests.swift
//
//
//  Created by Martin Troup on 02.03.2021.
//

import XCTest
import OvertureOperators

final class CompositionTests: XCTestCase {
    func test_forward_composition_of_2_operators() {
        XCTAssertEqual("2", (increment >>> String.init)(1))
    }

    func test_backward_composition_of_2_operators() {
        XCTAssertEqual("2", (String.init <<< increment)(1))
    }

    func test_throwing_forward_composition_of_2_operators() {
        XCTAssertEqual("2", try (nonThrowing(increment) >>> String.init)(1))
        XCTAssertThrowsError(try (throwing(increment) >>> String.init)(1))
    }

    func test_throwing_backward_composition_of_2_operators() {
        XCTAssertEqual("2", try (String.init <<< nonThrowing(increment))(1))
        XCTAssertThrowsError(try (String.init <<< throwing(increment))(1))
    }

    func test_forward_composition_of_3_operators() {
        XCTAssertEqual("3", (increment >>> increment >>> String.init)(1))
    }

    func test_backward_composition_of_3_operators() {
        XCTAssertEqual("3", (String.init <<< increment <<< increment)(1))
    }

    func test_throwing_forward_composition_of_3_operators() {
        XCTAssertEqual("3", try (nonThrowing(increment) >>> nonThrowing(increment) >>> String.init)(1))
        XCTAssertThrowsError(try (throwing(increment) >>> throwing(increment) >>> String.init)(1))
    }

    func test_throwing_backward_composition_of_3_operators() {
        XCTAssertEqual("3", try (String.init <<< nonThrowing(increment) <<< nonThrowing(increment))(1))
        XCTAssertThrowsError(try (String.init <<< throwing(increment) <<< throwing(increment))(1))
    }
}

// MARK: - Helper functions

extension CompositionTests {
    private struct ExpectedError: Error {}

    private func throwing<A, B>(_: (A) -> B) -> (A) throws -> B {
        { _ in
            throw ExpectedError()
        }
    }

    private func nonThrowing<A, B>(_ f: @escaping (A) -> B) -> (A) throws -> B {
        f
    }

    private func increment(_ x: Int) -> Int {
        x + 1
    }
}
