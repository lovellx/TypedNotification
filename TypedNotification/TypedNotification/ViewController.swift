//
//  ViewController.swift
//  TypedNotification
//
//  Created by lovellx on 2018/8/2.
//  Copyright © 2018年 lovellx. All rights reserved.
//

import UIKit

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

class ViewController: UIViewController {

    var notiToken: NotificationToken?
    override func viewDidLoad() {
        super.viewDidLoad()
        notiToken = TestNotificaiton.observer(for: .test) { [weak self](testObj) in
            let alertController = UIAlertController(title: "", message: "recieve: \(testObj.num) \(testObj.str)", preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "确定", style: .default)
            alertController.addAction(action)
            self?.present(alertController, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func send(_ sender: Any) {
        let testDescriptor = TestNotificaiton.init(1, str: "fine")
        testDescriptor.post()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

