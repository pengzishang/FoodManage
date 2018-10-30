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
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (_) in
                
            })
        }
    }
    
    fileprivate var _didOpenAsk = UserDefaults.standard.bool(forKey: "didOpenAsk")
    open var didOpenAsk : Bool {
        set {
            _didOpenAsk = newValue
            UserDefaults.standard.set(newValue, forKey: "didOpenAsk")
        } get {
            return _didOpenAsk
        }
    }
    
    fileprivate var _firstOpenTime : TimeInterval? = UserDefaults.standard.double(forKey: "firstOpenTime")
    open var firstOpenTime : Date? {
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue.timeIntervalSince1970, forKey: "firstOpenTime")
            }
        } get {
            if let time = _firstOpenTime {
                return Date.init(timeIntervalSince1970: time)
            }
            return nil
        }
    }
    
    open func addLocalNotification() {
        UNUserNotificationCenter.current().delegate = self
        let content = UNMutableNotificationContent.init()
        content.title = "dddd"
        content.body = "ssss"
        content.subtitle = "sdsdsdsds"

        content.categoryIdentifier = "ddddddd"
//        content.userInfo = ["IMG":imageURL]
        
        if let imageURL = Bundle.main.url(forResource: "Demo", withExtension: "png") {
            do {
                let attachment = try UNNotificationAttachment.init(identifier: "dddd", url: imageURL, options: .none)
                content.attachments = [attachment]
                
            }
            catch {

            }
        }
    
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        
        
        let test1 = UNNotificationAction.init(identifier: "test1", title: "ok", options: .authenticationRequired)
        let test2 = UNNotificationAction.init(identifier: "test2", title: "ok", options: .destructive)
        let text  = UNTextInputNotificationAction.init(identifier: "yeah", title: "text", options: .authenticationRequired, textInputButtonTitle: "hahaha", textInputPlaceholder: "input")
        let category = UNNotificationCategory.init(identifier: "ddddddd", actions: [test1,test2,text], intentIdentifiers: [], options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        let request = UNNotificationRequest.init(identifier: "ddddddd", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            
        }


    }
    
    open func getStatus(_ isOpen:@escaping (Bool)->()){
        UNUserNotificationCenter.current().getNotificationSettings { (setting) in
            switch setting.alertSetting {
            case .enabled:
                isOpen(true)
            default:
                isOpen(false)
            }
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
