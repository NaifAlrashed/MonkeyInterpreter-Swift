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
    
    func test_letVariable_equal_number_without_semicolon() {
        var parser = Parser(lexer: Lexer(input: "let x = 5"))
        XCTAssertEqual(parser.parse(), [])
    }
    
    func test_letVariable_equal_number_plus_number() {
        var parser = Parser(lexer: Lexer(input: "let x = 5 + 34;"))
        XCTAssertEqual(parser.parse(), [.let(name: "x", value: .addition(lhs: .number(value: 5), rhs: .number(value: 34)))])
    }
    
    func test_letVariable_equal_number_plus_number_without_semiconol() {
        var parser = Parser(lexer: Lexer(input: "let x = 5 + 34"))
        XCTAssertEqual(parser.parse(), [])
    }
    
    func test_multiple_additions() {
        var parser = Parser(lexer: Lexer(input: "let x = 5 + 34 + 100 + 300 + 400;"))
        XCTAssertEqual(parser.parse(), [.let(name: "x", value:
            .addition(lhs: .number(value: 5), rhs:
                .addition(lhs: .number(value: 34), rhs:
                    .addition(lhs: .number(value: 100), rhs:
                        .addition(lhs: .number(value: 300), rhs: .number(value: 400))))))])
    }
}
