//
//  Program.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 12/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

struct Program: Node {
    let statements: [Statement]
    
    var token: Token {
        guard let statement = statements.first else { return .illegal }
        return statement.token
    }
}
