//
//  JSParser.swift
//  JSFunction
//
//  Created by DH on 2020/05/24.
//  Copyright © 2020 outofcode. All rights reserved.
//

import Foundation

public final class JSParser {
    private let functionString: String
    
    public init(_ functionString: String) {
        self.functionString = functionString
    }
    
    public func parse() -> Data? {
        guard let nameEndIndex = functionString.firstIndex(of: "(") else {
            return nil
        }
        
        let name = String(functionString[..<nameEndIndex])
        var parameters: [String] = []
        
        if let endIndex = functionString.lastIndex(of: ")") {
            let startIndex = functionString.index(after: nameEndIndex)
            let endIndex = functionString.index(before: endIndex)
            
            if startIndex < endIndex {
                let params = functionString[startIndex...endIndex]
                if params.contains("{") && params.contains("}") {
                    parameters = [String(params)]
                } else {
                    parameters = params.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
                }
            }
        }
        
        return Data(name: name, parameters: parameters)
    }
    
    public struct Data {
        public var name: String
        public var parameters: [String]
        
        public init(name: String, parameters: [String]) {
            self.name = name
            self.parameters = parameters
        }
    }
}
