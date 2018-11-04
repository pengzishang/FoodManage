//
//  AddFoodController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/31.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import STPopup
import QMUIKit

class AddFoodController: UIViewController {
    
    lazy var addExpirationVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddExpirationController")
    
    @IBOutlet weak var imageView: EasyImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let width = (self.view.frame.width - 20 - 40)
        let photoHeight = width * 2448/3264
        self.contentSizeInPopup = CGSize.init(width: self.view.frame.width - 40, height: photoHeight + 120)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    
    
    @IBAction func didClickTakePhoto(_ sender: EasyButton) {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "拍一张!", style: .default, handler: { (_) in
            
        }))
        alert.addAction(UIAlertAction.init(title: "选一张!", style: .default, handler: { (_) in
            if QMUIAssetsManager.authorizationStatus() == .notDetermined{
                QMUIAssetsManager.requestAuthorization({ (status) in
                    DispatchQueue.main.async {
                        self.presentAlbumViewController()
                    }
                })
            } else {
                self.presentAlbumViewController()
            }
        }))
        self.present(alert, animated: true) {
            
        }
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let takePhoto = UIImagePickerController.init(rootViewController: self)
//            takePhoto.delegate = self
//            self.present(takePhoto, animated: true) {
//                
//            }
//        } else {
//            //需要权限
//        }
        
//        let takePhoto = UIImagePickerController()
//        takePhoto.delegate = self
//        self.present(takePhoto, animated: true) {
//
//        }
//        self.contentSizeInPopup = CGSize.init(width: self.view.frame.width, height: 200)
        
//        self.popupController?.push(addExpirationVC, animated: true)
    }
    
    fileprivate func presentAlbumViewController() {
        self.performSegue(withIdentifier: "AddFoodController2AlbumViewController", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate func putImage(with imageAsset:QMUIAsset) {
        imageAsset.requestImageData({ (imageData, info, isGif, isHEIC) in
            var targetImage : UIImage
            if (isGif) {
                targetImage = UIImage.qmui_animatedImage(with: imageData)
            } else {
                targetImage = UIImage.init(data: imageData!)!
                if (isHEIC) {
                    // iOS 11 中新增 HEIF/HEVC 格式的资源，直接发送新格式的照片到不支持新格式的设备，照片可能会无法识别，可以先转换为通用的 JPEG 格式再进行使用。
                    // 详细请浏览：https://github.com/QMUI/QMUI_iOS/issues/224
                    
                    let targetData = UIImage.init().jpegData(compressionQuality: 1)
                    targetImage = UIImage.init(data: targetData!)!
                }
            }
            self.imageView.image = targetImage
        })
    }
    
    @IBAction func unwindToAddFood(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == AlbumPreviewController.unwindId {
            let sourceViewController = unwindSegue.source as! AlbumPreviewController
//            [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerPreviewViewController.assetsGroup ablumContentType:kAlbumContentType userIdentify:nil];
//            QMUIImagePickerHelper.updateLastestAlbum(with: sourceViewController.imageAsset, ablumContentType: .onlyPhoto, userIdentify: nil)
//            let imageAsset = sourceViewController.imageAsset
            self.putImage(with: sourceViewController.imageAsset!)
        } else if unwindSegue.identifier == AlbumViewController.unwindId {
//            let imageAsset = sourceViewController.imageAsset.
            let sourceViewController = unwindSegue.source as! AlbumViewController
//            let imageAsset = sourceViewController.imageAssets?.first
            self.putImage(with: (sourceViewController.imageAssets?.first!)!)
        }
        // Use data from the view controller which initiated the unwind segue
    }

}
