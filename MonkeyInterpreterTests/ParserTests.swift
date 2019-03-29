//
//  ParserTests.swift
//  MonkeyInterpreterTests
//
//  Created by Naif Alrashed on 29/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

import XCTest
@testable import MonkeyInterpreter

class ParserTests: XCTestCase {

    func test_letVariable_equal_number() {
        var parser = Parser(lexer: Lexer(input: "let x = 5;"))
        XCTAssertEqual(parser.parse(), [.let(name: "x", value: .number(value: 5))])
    }
}
