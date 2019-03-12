//
//  Token.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 01/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

enum Token: Equatable {
    
    case illegal
    case EOF
    
    // Operators
    case assign
    case plus
    case minus
    case bang
    case times
    case divide
    case equal
    case biggerThan
    case smallerThan
    
    // Delimiters
    case comma
    case semicolon
    
    case leftParanthases
    case rightParanthases
    case leftBrace
    case rightBrace
    
    // Keywords
    case function
    case `let`
    case `if`
    case `else`
    case `return`
    case `true`
    case `false`
    
    case variable(name: String)
    case int(value: Int)
}
