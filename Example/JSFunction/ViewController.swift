//
//  ViewController.swift
//  JSFunction
//
//  Created by DH on 05/24/2020.
//  Copyright (c) 2020 DH. All rights reserved.
//

import UIKit
import WebKit
import JSFunction

class ViewController: UIViewController {
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let script = TestScript(name: "test")
        
        let userContentController = WKUserContentController()
        userContentController.add(function: script)
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        webView = WKWebView(frame: view.frame, configuration: configuration)
        view.addSubview(webView)
        
        let localFile = Bundle.main.path(forResource: "test", ofType: "html") ?? ""
        let url = URL(fileURLWithPath: localFile)
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

@objcMembers
final class TestScript : NSObject, JSFunction {
    
    var name: String = "test"
    
    init(name: String) {
        self.name = name
    }
    
    func message1() {
        print("\(type(of: self)).\(#function)")
    }
    
    func message2(_ text: String) {
        print("\(type(of: self)).\(#function) text = \(text)")
    }
    
    func message3(_ text1: String, _ text2: String) {
        print("\(type(of: self)).\(#function) text1=\(text1) text2=\(text2)")
    }
    
    func json(_ json: String) {
        guard let model = json.decode(type: JsonModel.self) else { return }
        print("\(type(of: self)).\(#function) name=\(model.name), age=\(model.age)")
    }
    
    struct JsonModel : Decodable {
        var name: String
        var age: Int
    }
}
