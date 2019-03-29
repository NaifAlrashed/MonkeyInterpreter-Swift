//
//  Parser.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 12/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

struct Parser {
    
    private var lexer: Lexer
    
    lazy var tokens: [Token] = {
        return lexer.tokenize()
    }()
    
    init(lexer: Lexer) {
        self.lexer = lexer
    }
    
    mutating func parse() -> [Statement] {
        var resultedTokens = ArraySlice(tokens)
        var statements = [Statement]()
        while let statement = resultedTokens.readStatement() {
            statements.append(statement)
        }
        return statements
    }
}

extension ArraySlice where Element == Token {
    
    mutating func readStatement() -> Statement? {
        return readLetStatement()
    }
    
    mutating func readLetStatement() -> Statement? {
        let start = self
        guard self.popFirst() == .let,
            let potentialVariable = popFirst(),
            self.popFirst() == .assign,
            case .variable(let name) = potentialVariable,
            let expression = readExpression()
        else {
            self = start
            return nil
        }
        return .let(name: name, value: expression)
    }
    
    mutating func readExpression() -> Expression? {
        let start = self
        guard let potentialNumber = popFirst(),
            case .int(let value) = potentialNumber,
            let potentialSemicolon = popFirst(),
            case .semicolon = potentialSemicolon
        else {
            self = start
            return nil
        }
        return Expression.number(value: value)
    }
}
