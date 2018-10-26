//
//  HomePageController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/25.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import Schedule

class HomePageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        Plan.after(Interval.init(seconds: 5.0)).do {
//            PushManager.share.addLocalNotification()
//        }
        PushManager.share.addLocalNotification()
        
        
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
