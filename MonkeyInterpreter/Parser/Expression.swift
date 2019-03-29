//
//  Expression.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 12/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

indirect enum Expression: Equatable {
    case number(value: Int)
    case addition(lhs: Expression, rhs: Expression)
}
