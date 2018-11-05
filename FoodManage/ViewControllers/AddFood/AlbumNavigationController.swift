//
//  AlbumNavigationController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/11/5.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import QMUIKit
import WRNavigationBar

class AlbumNavigationController: QMUINavigationController {

    static let unwind = "AlbumNavigationControllerBack"
    open var imageAsset : QMUIAsset?
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension AlbumNavigationController : QMUINavigationControllerAppearanceDelegate {
    func shouldSetStatusBarStyleLight() -> Bool {
        return false
    }
    
    func navigationBarTintColor() -> UIColor? {
        return UIColor.black
    }
}
