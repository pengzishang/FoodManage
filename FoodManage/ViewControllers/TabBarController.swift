//
//  TabBarController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/29.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PushManager.share.getStatus { (isOpen) in
            if !isOpen {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.performSegue(withIdentifier: "TabBarController2AskPermissionController", sender: nil)
                }
            } else  {
                
            }
            //需要一个标志位,区别是否同意
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
