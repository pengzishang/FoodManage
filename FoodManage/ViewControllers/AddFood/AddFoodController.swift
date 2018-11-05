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
import NVActivityIndicatorView

class AddFoodController: QMUICommonViewController {
    
    lazy var addExpirationVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddExpirationController")
    
    
    @IBOutlet weak var activityView: NVActivityIndicatorView!
    @IBOutlet weak var imageView: EasyImageView!
    @IBOutlet weak var photoHeight: NSLayoutConstraint!
    @IBOutlet weak var photoWidth: NSLayoutConstraint!
    var isNew = false
    
    
    override func didInitialize() {
        super.didInitialize()
        self.title = "拍照!"
        self.contentSizeInPopup = CGSize.init(width: UIScreen.main.bounds.width - 40, height: (UIScreen.main.bounds.width - 40) * 2448/3264 + 120)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !isNew {
            let image = UIImage.init(named: "Capa1")
            let ratio = image!.size.width/image!.size.height
            let height = (UIScreen.main.bounds.width - 20 - 40) / ratio
            self.photoHeight.constant = height
            self.photoWidth.constant = (UIScreen.main.bounds.width - 20 - 40)
            self.imageView.image = image
        }
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
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        self.present(alert, animated: true) {
            
        }
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
        self.activityView.startAnimating()
        isNew = true
        imageAsset.requestImageData({ (imageData, info, isGif, isHEIC) in
            var targetImage : UIImage
            if (isGif) {
                targetImage = UIImage.qmui_animatedImage(with: imageData)
            } else {
                targetImage = UIImage.init(data: imageData!)!
                if (isHEIC) {
                    var targetImage = UIImage.init(data: imageData!)!
                    let targetData = targetImage.jpegData(compressionQuality: 1)
                    targetImage = UIImage.init(data: targetData!)!
                }
            }
            
            self.changeImageView(with: targetImage)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.activityView.stopAnimating()
        }
    }
    
    fileprivate func changeImageView(with image:UIImage) {
        let ratio = image.size.width/image.size.height
        let height = (UIScreen.main.bounds.width - 20 - 40) / ratio
        if height > UIScreen.main.bounds.height - 300 {
            self.photoHeight.constant = UIScreen.main.bounds.height - 300
            self.photoWidth.constant = self.photoHeight.constant * ratio
        } else {
            self.photoHeight.constant = height
            self.photoWidth.constant = (UIScreen.main.bounds.width - 20 - 40)
        }
        self.contentSizeInPopup = CGSize.init(width: self.view.frame.width, height: self.photoHeight.constant + 120)
        self.imageView.image = image
    }
    
    @IBAction func unwindToAddFood(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == AlbumPreviewController.unwindId {
            let sourceViewController = unwindSegue.source as! AlbumPreviewController
            self.putImage(with: sourceViewController.imageAsset!)
        } else if unwindSegue.identifier == AlbumViewController.unwindId {
            let sourceViewController = unwindSegue.source as! AlbumViewController
            self.putImage(with: (sourceViewController.imageAssets?.first!)!)
        } else if unwindSegue.identifier == AlbumNavigationController.unwind {
            let sourceViewController = unwindSegue.source as! AlbumNavigationController
            self.putImage(with: sourceViewController.imageAsset!)
        }
        // Use data from the view controller which initiated the unwind segue
    }

}
