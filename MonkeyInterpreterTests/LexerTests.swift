//
//  MonkeyInterpreterTests.swift
//  MonkeyInterpreterTests
//
//  Created by Naif Alrashed on 01/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

import XCTest
@testable import MonkeyInterpreter

class LexerTests: XCTestCase {
    
    func test_lexerInput() {
        let input = "=+(){},;"
        var lexer = Lexer(input: input)
        
        let expectedTokens: [Token] = [
            .assign,
            .plus,
            .leftParanthases,
            .rightParanthases,
            .leftBrace,
            .rightBrace,
            .comma,
            .semicolon,
            .EOF
        ]
        XCTAssertEqual(lexer.tokenize(), expectedTokens)
        }
    
    func test_oneLine_ofMonkeyCode() {
        let input = "let five = 5;"
        var lexer = Lexer(input: input)
        let expectedTokens: [Token] = [
            .let,
            .variable(name: "five"),
            .assign,
            .int(value: 5),
            .semicolon,
            .EOF
        ]
        
        XCTAssertEqual(lexer.tokenize(), expectedTokens)
    }
    
    func test_firstMonkeyCode() {
        let input = """
                    let five = 5;
                    let ten = 10;
                    let add = fn(x, y) {
                         x + y;
                    };
                    let result = add(five, ten);
                    """
        var lexer = Lexer(input: input)

        let expectedTokens: [Token] = [
            .let,
            .variable(name: "five"),
            .assign,
            .int(value: 5),
            .semicolon,
            .let,
            .variable(name: "ten"),
            .assign,
            .int(value: 10),
            .semicolon,
            .let,
            .variable(name: "add"),
            .assign,
            .function,
            .leftParanthases,
            .variable(name: "x"),
            .comma,
            .variable(name: "y"),
            .rightParanthases,
            .leftBrace,
            .variable(name: "x"),
            .plus,
            .variable(name: "y"),
            .semicolon,
            .rightBrace,
            .semicolon,
            .let,
            .variable(name: "result"),
            .assign,
            .variable(name: "add"),
            .leftParanthases,
            .variable(name: "five"),
            .comma,
            .variable(name: "ten"),
            .rightParanthases,
            .semicolon,
            .EOF
        ]

        XCTAssertEqual(lexer.tokenize(), expectedTokens)
    }
    
    func test_newTokens() {
        let input = """
                    !-/*5;
                    5 < 10 > 5;

                    if (5 < 10) {
                        return true;
                    } else {
                        return false;
                    }

                    10 == 10;
                    10 != 9;
                    """
        var lexer = Lexer(input: input)
        
        let expectedTokens: [Token] = [
            .bang,
            .minus,
            .divide,
            .times,
            .int(value: 5),
            .semicolon,
            .int(value: 5),
            .smallerThan,
            .int(value: 10),
            .biggerThan,
            .int(value: 5),
            .semicolon,
            .if,
            .leftParanthases,
            .int(value: 5),
            .smallerThan,
            .int(value: 10),
            .rightParanthases,
            .leftBrace,
            .return,
            .true,
            .semicolon,
            .rightBrace,
            .else,
            .leftBrace,
            .return,
            .false,
            .semicolon,
            .rightBrace,
            .int(value: 10),
            .equal,
            .int(value: 10),
            .semicolon,
            .int(value: 10),
            .bang,
            .assign,
            .int(value: 9),
            .semicolon,
            .EOF
        ]
        
        XCTAssertEqual(lexer.tokenize(), expectedTokens)
    }
}
