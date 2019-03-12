//
//  LetStatement.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 12/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

import Foundation

struct LetStatement: Statement {
    
    let token: Token = .let
    let name: Identifier
    let value: Expression
    
    func statementNode() {
    }
}
