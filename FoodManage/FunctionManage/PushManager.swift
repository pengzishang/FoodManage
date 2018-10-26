//
//  PushManager.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/25.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import UserNotifications

class PushManager: NSObject {
    
    static let share = PushManager()
    
    @IBOutlet weak var target: UIViewController!
    
    @IBAction func requestPushPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (_, error) in
            print("\(error)")
        }
    }
    
    open func addLocalNotification() {
        UNUserNotificationCenter.current().delegate = self
        let content = UNMutableNotificationContent.init()
        content.title = "dddd"
        content.body = "ssss"
        content.subtitle = "sdsdsdsds"
        content.userInfo = ["DD":"SS"]
        content.sound = UNNotificationSound.default
        
        
        if let imageURL = Bundle.main.url(forResource: "Demo", withExtension: "png") {
            do {
                let attachment = try UNNotificationAttachment.init(identifier: "ddd", url: imageURL, options: .none)
                content.attachments = [attachment]
            }
            catch {
                
            }
        }
    
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        
        
        
        let request = UNNotificationRequest.init(identifier: "request", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            print("222222")
        }
        
    }
    
    
}

extension PushManager : UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.badge, .sound, .alert])
        print(notification.request.content.userInfo)
    }
    
    //程序在后台点击打开
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
    }
}
