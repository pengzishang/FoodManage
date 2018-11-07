//
//  HomePageController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/25.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import WRNavigationBar
import SnapKit
import STPopup
import QMUIKit
import VegaScrollFlowLayout

class HomePageController: UIViewController {
    
    @IBOutlet var emptyMainView: UIView!
    @IBOutlet var emptyTableGesture: UITapGestureRecognizer!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var addFoodVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFoodController") as! AddFoodController
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = VegaScrollFlowLayout()
        
        layout.minimumLineSpacing = 00
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        collectionView.collectionViewLayout = layout

//        PushManager.share.addLocalNotification()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didBeginAdding(_ sender: Any) {
        let popupController  = STPopupController.init(rootViewController: addFoodVC)
        popupController.containerView.layer.cornerRadius = 10
        let bgView = UIView.init()
        bgView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        popupController.backgroundView = bgView
        popupController.navigationBar.tintColor = UIColor.white
        popupController.navigationBar.barTintColor = UIColor.orange
        popupController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        popupController.present(in: self, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addFoodVC.isNext = false
        addFoodVC.isNew = false
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

extension HomePageController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.data()
        return cell
    }
}


extension HomePageController : DZNEmptyDataSetSource ,DZNEmptyDataSetDelegate{

    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return self.emptyMainView
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -80
    }
}


class HomeCell: UICollectionViewCell {
    @IBOutlet weak var progressView: UIView!
    
    func data() {
        progressView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let progress = LDProgressView.init()
        progress.animate = true
        progress.color = UIColor.red
        progress.progress = 0.4
        progress.flat = true
        progress.type = .stripes
        progress.progressInset = 1
        progress.background = UIColor.clear
        progress.showBackgroundInnerShadow = false
        progress.animateDirection = .backward;
        progress.borderRadius = 3
        self.progressView.addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    

}
