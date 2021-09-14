//
//  KeyPathsTests.swift
//  
//
//  Created by Martin Troup on 02.03.2021.
//

import XCTest
import Overture
import OvertureOperators

final class KeyPathsTests: XCTestCase {
    func test_get_operator() {
        let wrappedValueArray: [WrappedValue] = [.init(value: 1), .init(value: 2), .init(value: 3)]
        let valueArray = wrappedValueArray.map(^\.value)

        XCTAssertEqual([1, 2, 3], valueArray)
    }

    func test_prop_operator() {
        let incrementInnerValue = (^\WrappedValue.value)({ $0 + 1 })

        let wrappedValueArray: [WrappedValue] = [.init(value: 1), .init(value: 2), .init(value: 3)]
        let incrementedWrappedValueArray = wrappedValueArray.map(incrementInnerValue)

        XCTAssertEqual([.init(value: 2), .init(value: 3), .init(value: 4)], incrementedWrappedValueArray)
    }

    func test_set_with_prop_operator() {
        let resetToDefaultValue = set(^\WrappedValue.value, 0)
        let wrappedValueArray: [WrappedValue] = [.init(value: 1), .init(value: 2), .init(value: 3)]
        let incrementedWrappedValueArray = wrappedValueArray.map(resetToDefaultValue)

        XCTAssertEqual([.init(value: 0), .init(value: 0), .init(value: 0)], incrementedWrappedValueArray)
    }

    func test_over_with_prop_operator() {
        let incrementInnerValue = over(^\WrappedValue.value, { $0 + 1 })

        let wrappedValueArray: [WrappedValue] = [.init(value: 1), .init(value: 2), .init(value: 3)]
        let incrementedWrappedValueArray = wrappedValueArray.map(incrementInnerValue)

        XCTAssertEqual([.init(value: 2), .init(value: 3), .init(value: 4)], incrementedWrappedValueArray)
    }
}

// MARK: - Helper functions

extension KeyPathsTests {
    struct WrappedValue: Equatable {
        var value: Int
    }
}
