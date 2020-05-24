import XCTest

import WebKit
import JSFunction

class Tests: XCTestCase {
    
    var script: TestScript!
    var jsHandler: JSHandler!
    
    override func setUp() {
        super.setUp()
        
        script = TestScript(name: "test")
        jsHandler = JSHandler(script)
        
        let controller = WKUserContentController()
        controller.add(jsHandler, name: script.name)
    }

    func testSelector1() {
        let data = JSParser.Data(name: "message1", parameters: [])
        let result = jsHandler.sendSelector(data: data)
        XCTAssertEqual(result, true)
    }
    
    func testSelector2() {
        let data = JSParser.Data(name: "message2", parameters: ["test1"])
        let result = jsHandler.sendSelector(data: data)
        XCTAssertEqual(result, true)
    }
    
    func testSelector3() {
        let data = JSParser.Data(name: "message3", parameters: ["test1"])
        let result = jsHandler.sendSelector(data: data)
        XCTAssertEqual(result, false)
    }
    
    func testSelector4() {
        let data = JSParser.Data(name: "message3", parameters: ["test1", "test2"])
        let result = jsHandler.sendSelector(data: data)
        XCTAssertEqual(result, true)
    }
    
    func testSelector5() {
        let json = #"{"name":"DH","age":29}"#
        let data = JSParser.Data(name: "json", parameters: [json])
        let result = jsHandler.sendSelector(data: data)
        XCTAssertEqual(result, true)
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
