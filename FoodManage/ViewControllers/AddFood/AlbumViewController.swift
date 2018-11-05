//
//  AlbumViewController.swift
//  FoodManage
//
//  Created by pzs on 2018/11/4.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import QMUIKit
import WRNavigationBar

class AlbumViewController: QMUIAlbumViewController {

    static let unwindId = "AlbumViewControllerBack"
    
    var imageAssets : [QMUIAsset]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumViewControllerDelegate = self
        self.pickLastAlbumGroupDirectlyIfCan()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wr_setNavBarTintColor(UIColor.black)
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

extension AlbumViewController :QMUIAlbumViewControllerDelegate {
    func imagePickerViewController(for albumViewController: QMUIAlbumViewController!) -> QMUIImagePickerViewController! {
        let picker = AlbumImagePickerController.init()
        return picker
    }
}




