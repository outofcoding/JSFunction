//
//  WKWebView+.swift
//  JSFunction
//
//  Created by DH on 2020/05/24.
//  Copyright © 2020 outofcode. All rights reserved.
//

import WebKit

public extension WKWebView {
    func add(javascript: JSFunction) {
        let contentController = WKUserContentController()
        contentController.add(function: javascript)
    }
}

public extension WKUserContentController {
    func add(function: JSFunction) {
        let messageHandler = JSHandler(function)
        add(messageHandler, name: function.name)
    }
}

public extension String {
    func decode<Model: Decodable>(type: Model.Type) -> Model? {
        guard let data = data(using: .utf8) else { return nil }
        
        do {
            let decode = try JSONDecoder().decode(type, from: data)
            return decode
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        return nil
        
    }
}
