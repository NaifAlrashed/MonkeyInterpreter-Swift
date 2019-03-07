//
//  Lexer.swift
//  MonkeyInterpreter
//
//  Created by Naif Alrashed on 01/03/2019.
//  Copyright © 2019 Naif Alrashed. All rights reserved.
//

import Foundation

struct Lexer {
    
    private let input: String.UnicodeScalarView
    private var currentIndex: String.UnicodeScalarIndex
    
    var count: Int {
        return input.count + 1
    }
    
    init(input: String) {
        self.input = input.unicodeScalars
        currentIndex = input.unicodeScalars.startIndex
    }
    
    mutating func tokenize() -> [Token] {
        
        var tokens = [Token]()
        
        while let token = nextToken()  {
            tokens.append(token)
        }
        
        tokens.append(.EOF)
        
        return tokens
    }
    
    mutating func nextToken() -> Token? {
        
        guard currentIndex != input.endIndex else {
            return nil
        }
        
        escapeUneededCharacters()
        
        let value = input[currentIndex]
        
        if let token = tokenize(singleCharacter: value) { return token }
        
        if let token = tokenizeNumber() { return token }
        
        let startIndex = currentIndex
        for string in input[currentIndex..<input.endIndex] {
            if !CharacterSet.letters.contains(string) {
                break
            }
            currentIndex = input.index(after: currentIndex)
        }
        let word = input[startIndex..<currentIndex]
        return tokenize(word: String(word))
    }
    
    private mutating func escapeUneededCharacters() {
        for string in input[currentIndex..<input.endIndex] {
            if !CharacterSet.whitespacesAndNewlines.contains(string) {
                break
            }
            currentIndex = input.index(after: currentIndex)
        }
    }
    
    private mutating func tokenize(singleCharacter char: Unicode.Scalar) -> Token? {
        switch char {
        case "=":
            currentIndex = input.index(after: currentIndex)
            return .assign
        case "+":
            currentIndex = input.index(after: currentIndex)
            return .plus
        case "(":
            currentIndex = input.index(after: currentIndex)
            return .leftParanthases
        case ")":
            currentIndex = input.index(after: currentIndex)
            return .rightParanthases
        case "{":
            currentIndex = input.index(after: currentIndex)
            return .leftBrace
        case "}":
            currentIndex = input.index(after: currentIndex)
            return .rightBrace
        case ",":
            currentIndex = input.index(after: currentIndex)
            return .comma
        case ";":
            currentIndex = input.index(after: currentIndex)
            return .semicolon
        default:
            return nil
        }
    }
    
    mutating private func tokenizeNumber() -> Token? {
        let startIndex = currentIndex
        for value in input[currentIndex..<input.endIndex] {
            let string = String(value)
            if let _ = Int(string) {
                currentIndex = input.index(after: currentIndex)
            } else {
                break
            }
        }
        let string = String(input[startIndex..<currentIndex])
        if let integer = Int(string) {
            return .int(value: integer)
        } else {
            currentIndex = startIndex
            return nil
        }
    }
    
    private func tokenize(word: String) -> Token? {
        switch word {
        case "let":
            return .let
        case "fn":
            return .function
        default:
            return .variable(name: word)
        }
    }
}
