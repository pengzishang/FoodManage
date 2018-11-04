//
//  AlbumPreviewController.swift
//  FoodManage
//
//  Created by pzs on 2018/11/4.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import QMUIKit

class AlbumPreviewController: QMUIImagePickerPreviewViewController {

    static let unwindId = "backToAlbumPreviewController"
    open var imageAsset : QMUIAsset?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "预览"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didClickUse(_ sender: Any) {
        self.dismiss(animated: true) {
            self.imageAsset =  self.imagesAssetArray![Int(self.imagePreviewView!.currentImageIndex)] as? QMUIAsset
            self.performSegue(withIdentifier: AlbumPreviewController.unwindId, sender: nil)
        }
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

extension AlbumPreviewController : QMUIImagePickerPreviewViewControllerDelegate {
    
}
