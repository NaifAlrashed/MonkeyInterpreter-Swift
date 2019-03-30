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

fileprivate extension ArraySlice where Element == Token {
    
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
        return readAddition()
    }
    
    mutating func readAddition() -> Expression? {
        let startBeforeOperand = self
        guard let operand = readOperand() else {
            self = startBeforeOperand
            return nil
        }
        
        let start = self
        
        guard let potentialAddition = popFirst(),
            case .plus = potentialAddition,
            let rhs = readExpression()
        else {
            self = start
            if let potentialSemicolon = popFirst(), case .semicolon = potentialSemicolon {
                return operand
            } else {
                self = startBeforeOperand
                return nil
            }
        }
        return .addition(lhs: operand, rhs: rhs)
    }
    
    mutating func readOperand() -> Expression? {
        guard let potentialNumber = popFirst(),
            case .int(let value) = potentialNumber
        else {
            return nil
        }
        return .number(value: value)
    }
}
