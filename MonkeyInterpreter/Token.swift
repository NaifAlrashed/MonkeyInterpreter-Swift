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
    
    case variable(name: String)
    case int(value: Int)
}
