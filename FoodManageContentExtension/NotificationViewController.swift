//
//  NotificationViewController.swift
//  FoodManageContentExtension
//
//  Created by DeshPeng on 2018/10/25.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        let attachment = notification.request.content.attachments.first
        if let start = attachment?.url.startAccessingSecurityScopedResource() , start{
            self.image.image = UIImage.init(contentsOfFile: (attachment?.url.path)!)
        }
    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        switch response.actionIdentifier {
        case "":
            break
        default:
            break
        }
    }
    
    
    
    
}
