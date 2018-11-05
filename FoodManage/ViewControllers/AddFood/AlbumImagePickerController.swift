//
//  AlbumImagePickerController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/11/5.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import QMUIKit

class AlbumImagePickerController: QMUIImagePickerViewController {

    var imageAssets : [QMUIAsset]?
    static let unwindId = "AlbumImagePickerControllerBack"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePickerViewControllerDelegate = self
        //        picker.maximumSelectImageCount = 1
        self.allowsMultipleSelection = false
        // Do any additional setup after loading the view.
    }
    
    override func didInitialize() {
        super.didInitialize()
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

extension AlbumImagePickerController : QMUIImagePickerViewControllerDelegate {
    func imagePickerViewController(_ imagePickerViewController: QMUIImagePickerViewController!, didFinishPickingImageWithImagesAssetArray imagesAssetArray: NSMutableArray!) {
        QMUIImagePickerHelper.updateLastestAlbum(with: imagePickerViewController.assetsGroup, ablumContentType: .onlyPhoto, userIdentify: nil)
        imagesAssetArray.forEach { (asset) in
            QMUIImagePickerHelper.requestImageAssetIfNeeded(asset as? QMUIAsset, completion: { (downloadStatus, error) in
                if downloadStatus == .downloading {
                    QMUITips.showLoading("从 iCloud 加载中", in: self.view)
                } else if downloadStatus == .succeed {
                    QMUITips.show(withText: "iCloud 下载错误，请重新选图", in: self.view, hideAfterDelay: 2)
                }
            })
        }
        self.imageAssets =  imagesAssetArray as? [QMUIAsset]
        self.performSegue(withIdentifier: AlbumImagePickerController.unwindId, sender: nil)
    }
    
    func imagePickerPreviewViewController(for imagePickerViewController: QMUIImagePickerViewController!) -> QMUIImagePickerPreviewViewController! {
        QMUIImagePickerHelper.updateLastestAlbum(with: imagePickerViewController.assetsGroup, ablumContentType: .onlyPhoto, userIdentify: nil)
        let picker = AlbumPreviewController.init()
        return picker
    }
}
