//
//  AlbumViewController.swift
//  FoodManage
//
//  Created by pzs on 2018/11/4.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import QMUIKit

class AlbumViewController: QMUIAlbumViewController {

    static let unwindId = "AlbumViewControllerBack"
    
    var imageAssets : [QMUIAsset]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumViewControllerDelegate = self
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

extension AlbumViewController :QMUIAlbumViewControllerDelegate {
    func imagePickerViewController(for albumViewController: QMUIAlbumViewController!) -> QMUIImagePickerViewController! {
        let picker = QMUIImagePickerViewController.init()
        picker.imagePickerViewControllerDelegate = self
        picker.maximumSelectImageCount = 1
        picker.allowsMultipleSelection = true
        return picker
    }
}
extension AlbumViewController : QMUIImagePickerViewControllerDelegate {
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
        self.dismiss(animated: true) {
            self.imageAssets =  imagesAssetArray as? [QMUIAsset]
            self.performSegue(withIdentifier: AlbumViewController.unwindId, sender: nil)
        }
    }
    
    func imagePickerPreviewViewController(for imagePickerViewController: QMUIImagePickerViewController!) -> QMUIImagePickerPreviewViewController! {
        let picker = self.storyboard?.instantiateViewController(withIdentifier: "AlbumPreviewController") as! AlbumPreviewController
        return picker
    }
}


