# JSFunction

[![CI Status](https://img.shields.io/travis/DH/JSFunction.svg?style=flat)](https://travis-ci.org/DH/JSFunction)
[![Version](https://img.shields.io/cocoapods/v/JSFunction.svg?style=flat)](https://cocoapods.org/pods/JSFunction)
[![License](https://img.shields.io/cocoapods/l/JSFunction.svg?style=flat)](https://cocoapods.org/pods/JSFunction)
[![Platform](https://img.shields.io/cocoapods/p/JSFunction.svg?style=flat)](https://cocoapods.org/pods/JSFunction)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JSFunction is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JSFunction'
```

## Author

OutOfCode, outofcoding@gmail.com
Bear, mrgamza@gmail.com

## License

JSFunction is available under the MIT license. See the LICENSE file for more info.

## Use

Create a class that inherits JSFunction.

```swift
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
```

add function WKUserContentController

```swift
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
```

Javascript side

```javascript
<script type="text/javascript">
    function message1() {
        var message = 'message1()';
        window.webkit.messageHandlers.test.postMessage(message);
    }

    function message2() {
        var message = 'message2(My Name is DH)';
        window.webkit.messageHandlers.test.postMessage(message);
    }

    function message3() {
        var message = 'message3(My Name is DH, 29 years old)';
        window.webkit.messageHandlers.test.postMessage(message);
    }

    function json() {
        var json = '{"name": "DH", "age": 29}';
        var message = 'json(' + json + ')';
        window.webkit.messageHandlers.test.postMessage(message);
    }
</script>
```
