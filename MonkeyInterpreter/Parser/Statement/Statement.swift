//
//  Statement.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 12/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

enum Statement: Equatable {
    case `let`(name: String, value: Expression)
}
