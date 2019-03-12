//
//  Parser.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 12/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

import Foundation

struct Parser {
    
    private var lexer: Lexer
    
    lazy var tokens: [Token] = {
        return lexer.tokenize()
    }()
    
    lazy var currentToken: Token = {
        guard let token = tokens.first else { return .EOF }
        return token
    }()
    
    lazy var peekToken: Token =  {
        return tokens.count >= 2 ? tokens[1]: .EOF
    }()
    
    init(lexer: Lexer) {
        self.lexer = lexer
    }
}
