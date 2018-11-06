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
    @IBOutlet weak var takePhotoBtn: EasyButton!
    @IBOutlet weak var confirmBtn: EasyButton!
    @IBOutlet weak var changeNameBtn: EasyButton!
    @IBOutlet weak var giveName: EasyButton!

    @IBOutlet weak var resultLab: UILabel!
    //两次后可更换图片

    var isNew = false
    var isNext = false
    let photoMargin: CGFloat = 40
    let viewMargin: CGFloat = 40

    let testArray: [String] =
//        []
            ["橘子","苹果","榴莲","葡萄","西瓜"]
    var resultIndex = 0
    enum Result {
        case error
        case success
        case change
    }
    
    let rightBarItem = UIBarButtonItem.qmui_item(withTitle: "换图片", target: self, action: #selector(popMethods))

    override func didInitialize() {
        super.didInitialize()
        self.title = "拍照!"
        self.contentSizeInPopup = CGSize.init(width: UIScreen.main.bounds.width - viewMargin, height: (UIScreen.main.bounds.width - viewMargin) * 2448/3264 + 150)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if !isNew && !isNext{
            let image = UIImage.init(named: "Capa1")
            self.changeImageView(with: image!, buttomMargin: 120)
            self.changeStatus(with: .success)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isNew = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @objc fileprivate func popMethods() {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "拍一张!", style: .default, handler: { (_) in
            
        }))
        alert.addAction(UIAlertAction.init(title: "选一张!", style: .default, handler: { (_) in
            if QMUIAssetsManager.authorizationStatus() == .notDetermined {
                QMUIAssetsManager.requestAuthorization({ (_) in
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
    
    @IBAction func didClickTakePhoto(_ sender: EasyButton) {
        self.popMethods()
    }

    @IBAction func didClickConfirm(_ sender: EasyButton) {
        DataManger.share.currentInputName = self.testArray[self.resultIndex]
        DataManger.share.currentImage = self.imageView.image
        self.isNext = true
        self.popupController?.push(self.addExpirationVC, animated: true)
    }

    @IBAction func didClickChangeName(_ sender: EasyButton) {
        self.changeStatus(with: .change)
    }

    @IBAction func didClickGiveName(_ sender: EasyButton) {
        let alert = UIAlertController.init(title: "起个名字吧", message: "这个东西叫什么?", preferredStyle: .alert)
        alert.addTextField { (_) in
            //TODO:下一步
        }
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (_) in
            if let text = alert.textFields?.first?.text {
                DataManger.share.currentInputName = text
                DataManger.share.currentImage = self.imageView.image
                self.isNext = true
                self.popupController?.push(self.addExpirationVC, animated: true)
            }
            //TODO:下一步
        }))
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (_) in

        }))
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

    fileprivate func putImage(with imageAsset: QMUIAsset) {
        self.activityView.startAnimating()

        imageAsset.requestImageData({ (imageData, _, isGif, isHEIC) in
            var targetImage: UIImage
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

            self.changeImageView(with: targetImage, buttomMargin: 120)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.changeImageView(with: targetImage, buttomMargin: 160)
                self.changeStatus(with: .change)
                self.activityView.stopAnimating()
            }
        })
        
    }

    fileprivate func changeStatus(with result: Result) {
        switch result {
        //成功后
        case .success:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.qmui_item(withTitle: "", target: self, action: #selector(popMethods))
            self.takePhotoBtn.isHidden = false
            self.resultLab.isHidden = true
            self.confirmBtn.isHidden = true
            self.changeNameBtn.isHidden = true
            self.giveName.isHidden = true
            self.resultIndex = 0
            self.resultLab.text = ""
        case .change:
            self.navigationItem.setRightBarButton(nil, animated: true)
            self.takePhotoBtn.isHidden = true
            self.resultLab.isHidden = false
            self.confirmBtn.isHidden = false
            self.giveName.isHidden = true
            if testArray.count > self.resultIndex {
                self.resultLab.text = testArray[self.resultIndex]
                self.changeNameBtn.isHidden = false
                self.resultIndex += 1
                if self.resultIndex > 2 {
                    self.giveName.isHidden = false
                    //TODO:出现更换图片item
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem.qmui_item(withTitle: "换图片", target: self, action: #selector(popMethods))
                }
            } else {
                self.changeNameBtn.isHidden = true
                self.giveName.isHidden = false
                self.resultLab.text = "识别不出哦,自己起个名字吧!"
                self.confirmBtn.isHidden = true
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.qmui_item(withTitle: "换图片", target: self, action: #selector(popMethods))
                //TODO:出现更换图片item
            }
        case .error:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.qmui_item(withTitle: "换图片", target: self, action: #selector(popMethods))
            self.takePhotoBtn.isHidden = true
            self.resultLab.isHidden = false
            self.resultLab.text = "网络错误,自己起个名字吧!"
            self.giveName.isHidden = false
            self.resultIndex = 0
            self.changeNameBtn.isHidden = true
            self.confirmBtn.isHidden = true
        }
    }

    fileprivate func changeImageView(with image: UIImage, buttomMargin:CGFloat) {

        let ratio = image.size.width/image.size.height
        let height = (UIScreen.main.bounds.width - photoMargin - viewMargin) / ratio
        if height > UIScreen.main.bounds.height - 300 {
            self.photoHeight.constant = UIScreen.main.bounds.height - 300
            self.photoWidth.constant = self.photoHeight.constant * ratio
        } else {
            self.photoHeight.constant = height
            self.photoWidth.constant = (UIScreen.main.bounds.width - photoMargin - viewMargin)
        }
        self.contentSizeInPopup = CGSize.init(width: self.view.frame.width, height: self.photoHeight.constant + buttomMargin)
        self.imageView.image = image
        isNew = true
        self.changeStatus(with: .success)
        
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
