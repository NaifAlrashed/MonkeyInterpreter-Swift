//
//  Identifier.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 12/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

struct Identifier: Expression {
    
    let name: String
    
    var token: Token {
        return .variable(name: name)
    }
    
    func expressionNode() {
    }
}
