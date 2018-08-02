# TypedNotification

a convenient way to use Notifications，reduce hardcode

## Example

- Define

```
extension Notification.Name {
    static let test = Notification.Name.init("com.typedNotification.test")
}

struct TestNotificaiton: TypedNotification {
    var name: Notification.Name { return .test }
    var userInfo: [AnyHashable : Any]? {
        return ["passedNum": num, "passedStr": str]
    }
    var num: Int
    var str: String
    init(_ notification: Notification) {
        num = notification.userInfo!["passedNum"] as! Int
        str = notification.userInfo!["passedStr"] as! String
    }
    init(_ num: Int, str: String) {
        self.num = num
        self.str = str
    }
}
```

- Post

```
let testDescriptor = TestNotificaiton.init(1, str: "it is fine")
testDescriptor.post()
```
- Recieve

```
let token = TestNotificaiton.observer(for: .test) { (testObj) in
    print("\(testObj.num) \(testObj.str)")
}
```
