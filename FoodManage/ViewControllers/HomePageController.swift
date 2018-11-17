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
import SwipeCellKit


class HomePageController: UIViewController {
    
    @IBOutlet var emptyMainView: UIView!
    @IBOutlet var emptyTableGesture: UITapGestureRecognizer!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var addFoodVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFoodController") as! AddFoodController
    var dataList = DataManger.share.fetchAll()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = VegaScrollFlowLayout()
        layout.minimumLineSpacing = 00
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        collectionView.collectionViewLayout = layout
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let cell = self.collectionView.visibleCells.first as? HomeCell{
                cell.showSwipe(orientation: .right)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    cell.hideSwipe(animated: true)
                })
            }
        }

        
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
        if dataList.count > 0 {
            collectionView.removeGestureRecognizer(emptyTableGesture)
        } else {
            collectionView.addGestureRecognizer(emptyTableGesture)
        }
        collectionView.reloadData()
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
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.data(with: dataList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as! HomeCell
//        cell.showSwipe(orientation: .right, animated: true) { (_) in
//
//        }
        cell.setSwipeOffset(10, animated: true) { (_) in
            
        }
        
    }
}

extension  HomeCell: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
        }
        
        // customize the action appearance
        deleteAction.image = #imageLiteral(resourceName: "Trash-circle")
        deleteAction.backgroundColor = .white
        deleteAction.textColor = .red
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = .border
        
        options.buttonSpacing = 4
        options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
        
        return options
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


class HomeCell: SwipeCollectionViewCell {
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var endDay: UILabel!
    @IBOutlet weak var during: UILabel!
    
    
    lazy var progress :LDProgressView = { [unowned self] in
        $0.animate = true
        $0.color = UIColor.red
        $0.flat = true
        $0.type = .stripes
        $0.progressInset = 1
        $0.background = UIColor.clear
        $0.showBackgroundInnerShadow = false
        $0.animateDirection = .backward;
        $0.borderRadius = 2
        $0.outerStrokeWidth = 0
        $0.showStroke = false
        return $0
    }(LDProgressView())
    
    
    func data(with model:FoodDateModel) {
        self.delegate = self
        
        progressView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        self.progressView.addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        imageView.image = UIImage.init(data: model.imageData!)
        if model.inputName != nil {
            mainTitle.text = model.inputName
        } else {
            mainTitle.text = model.suggestName
        }
        
        progress.progress = 0.4
        if model.productDate == nil || model.expireDate == nil {
            endDay.text = model.importDate?.addingTimeInterval(model.duration).toFormat("yyyy年MM月dd日")
            during.text = model.importDate?.addingTimeInterval(model.duration).timeIntervalSinceNow.toIntervalString()
            
        } else {
            endDay.text = model.expireDate?.toFormat("yyyy年MM月dd日")
            during.text = model.expireDate?.dateComponents.fromNow.toFormat("yyyy年MM月dd日")
        }
        
        
    }
    
}

