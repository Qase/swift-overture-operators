//
//  ForwardApplicationTests.swift
//  
//
//  Created by Martin Troup on 02.03.2021.
//

import XCTest
import OvertureOperators

final class ForwardApplicationTests: XCTestCase {
    func test_apply_increment_function() {
        XCTAssertEqual(3, 2 |> increment)
    }

    func test_apply_optional_increment_function() {
        XCTAssertEqual(.some(3), 2 |> optIncrement)
    }

    func test_apply_array_increment_function() {
        XCTAssertEqual([3], 2 |> arrayIncrement)
    }
}

extension ForwardApplicationTests {
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
