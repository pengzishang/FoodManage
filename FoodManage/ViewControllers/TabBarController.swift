//
//  TabBarController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/29.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import SwiftDate
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        PushManager.share.getStatus { (isOpen) in
            guard !isOpen else {return}
            if !PushManager.share.didOpenAsk {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.performSegue(withIdentifier: "TabBarController2AskPermissionController", sender: nil)
                }
            } else if let time = PushManager.share.firstOpenTime, (time + 2.minutes) <= Date() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.performSegue(withIdentifier: "TabBarController2AskPermissionController", sender: nil)
                }
            }
        }

        // Do any additional setup after loading the view.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
