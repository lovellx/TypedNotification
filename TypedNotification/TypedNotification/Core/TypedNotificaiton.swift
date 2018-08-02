//
//  TypedNotificaiton.swift
//  TypedNotification
//
//  Created by lovellx on 2018/8/2.
//  Copyright © 2018年 lovellx. All rights reserved.
//

import Foundation

/// a notificaiton descriptor
protocol NotificationDescriptor {
    var name: Notification.Name { get }
    var userInfo:[AnyHashable: Any]? { get }
    var object: Any? { get }
}

extension NotificationDescriptor {

    var userInfo:[AnyHashable: Any]? {
        return nil
    }
    var object: Any? {
        return nil
    }
}

extension NotificationDescriptor {
    func post(on center: NotificationCenter = NotificationCenter.default) {
        center.post(name: name, object: object, userInfo: userInfo)
    }
}

/// use to recieve a notificaiton
protocol NotificationDecodable {
    init(_ notification: Notification)
}

extension NotificationDecodable {
    static func observer(on center: NotificationCenter = NotificationCenter.default ,
                         for aName: Notification.Name,
                         queue: OperationQueue? = nil,
                         using block: @escaping (Self) -> Swift.Void) -> NotificationToken {
        let token = center.addObserver(forName: aName, object: nil, queue: queue, using: {
            block(Self.init($0))
        })
        return NotificationToken.init(token, center: center)
    }
}

typealias TypedNotification = NotificationDescriptor & NotificationDecodable

class NotificationToken {
    let token: NSObjectProtocol
    let center: NotificationCenter
    init(_ token: NSObjectProtocol, center: NotificationCenter) {
        self.token = token
        self.center = center
    }
    deinit {
        center.removeObserver(token)
    }
}
