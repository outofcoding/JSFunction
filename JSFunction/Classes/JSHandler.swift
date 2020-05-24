//
//  JSHandler.swift
//  JSFunction
//
//  Created by DH on 2020/05/24.
//  Copyright © 2020 outofcode. All rights reserved.
//

import Foundation
import WebKit

public class JSHandler : NSObject, WKScriptMessageHandler {
    
    private var jsFunction: JSFunction
    
    public init(_ jsFunction: JSFunction) {
        self.jsFunction = jsFunction
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == jsFunction.name,
            let body = message.body as? String,
            let data = JSParser(body).parse() else { return }
        
        sendSelector(data: data)
    }

    @discardableResult
    public func sendSelector(data: JSParser.Data) -> Bool {
        let paraJoin = data.parameters.map({ _ in ":" }).joined()
        let selector = Selector(data.name + paraJoin)

        guard jsFunction.responds(to: selector) else {
            return false
        }
        
        if data.parameters.isEmpty {
            jsFunction.perform(selector)
        } else if data.parameters.count == 1 {
            jsFunction.perform(selector, with: data.parameters[0])
        } else {
            jsFunction.perform(selector, with: data.parameters[0], with: data.parameters[1])
        }
        
        return true
    }
}
