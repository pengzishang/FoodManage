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

    static let unwindId = "AlbumPreviewControllerBack"
    open var imageAsset : QMUIAsset?
    let confirmBtn: UIButton = UIButton.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.wr_setNavBarTintColor(UIColor.black)
    }
    
    override func didInitialize() {
        super.didInitialize()
        setNeedsStatusBarAppearanceUpdate()
        confirmBtn.qmui_outsideEdge = UIEdgeInsets.init(top: -6, left: -6, bottom: -6, right: -6)
        confirmBtn.setTitle("就这张了!", for: .normal)
        confirmBtn.addTarget(self, action: #selector(didClickUse(_:)), for: .touchUpInside)
        confirmBtn.setTitleColor(self.toolBarTintColor, for: .normal)
        confirmBtn.sizeToFit()
        self.wr_setNavBarTintColor(UIColor.white)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.topToolBarView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func didClickUse(_ sender: Any) {
        self.selectedImageAssetArray = self.imagesAssetArray
        self.imageAsset =  self.imagesAssetArray![Int(self.imagePreviewView!.currentImageIndex)] as? QMUIAsset
        let nav = self.navigationController as! AlbumNavigationController
        nav.imageAsset = self.imageAsset
        nav.performSegue(withIdentifier: AlbumNavigationController.unwind, sender: nil)
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
