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
import Segmentio

protocol HomeCellDelegate : AnyObject {
    func didClickDeleteWith(indexPath:IndexPath) -> Bool
}


class TestCell: CBBaseGridCell {
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var price: UILabel!
    
//    @IBOutlet weak var lblTimer: UILabel!
//    @IBOutlet weak var lblPricer: UILabel!
}

class HeaderView: CBBaseHeader {
//    @IBOutlet weak var csTextBottom: NSLayoutConstraint!
//    @IBOutlet weak var csImageTop: NSLayoutConstraint!
    
    @IBOutlet weak var noticeLabelTop: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIApplication.shared.statusBarFrame.height > 20 {
            noticeLabelTop.constant += 24
        }
    }
    
    override func update(toAnimationProgress progress: CGFloat) {
        super.update(toAnimationProgress: progress)
//        csTextBottom.constant = 44 + 200 * progress
//        csImageTop.constant = -400 * progress * 1.5
        UIView.animate(withDuration: 0.01) {
            self.layoutIfNeeded()
        }
    }
}

class MenuView: CBBaseMenu {
    //    @IBOutlet weak var csImageLeft: NSLayoutConstraint!
    @IBOutlet open weak var segmentView: Segmentio!
    
    override func update(toAnimationProgress progress: CGFloat) {
        super.update(toAnimationProgress: progress)
        //        csImageLeft.constant = 50 - (50 - 30) * progress
        UIView.animate(withDuration: 0.01) {
            self.layoutIfNeeded()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        segmentView.setup(content: [SegmentioItem.init(title: "chicken", image: #imageLiteral(resourceName: "user")),SegmentioItem.init(title: "chicken", image: #imageLiteral(resourceName: "title")),SegmentioItem.init(title: "chicken", image: #imageLiteral(resourceName: "title")),SegmentioItem.init(title: "chicken", image: #imageLiteral(resourceName: "title"))], style: SegmentioStyle.onlyLabel, options: nil)
        segmentView.selectedSegmentioIndex = 1
    }

}


class HomePageController: UIViewController {

    @IBOutlet var emptyMainView: UIView!
    @IBOutlet var emptyTableGesture: UITapGestureRecognizer!
//    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var menu : MenuView = MenuView()
    
    let viewAnimator = CBViewAnimator()
    var titleSize: CGSize = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.wr_setNavBarBarTintColor(UIColor.clear)
        let Menu = UINib(nibName: "Menu", bundle: nil)
//        let menuView = Menu.instantiate(withOwner: <#T##Any?#>, options: <#T##[UINib.OptionsKey : Any]?#>)
        collectionView.register(UINib(nibName: "Header", bundle: nil),
                                forSupplementaryViewOfKind: CBSmoothScrollLayout.kCBAnimatedLayoutHeader,
                                withReuseIdentifier: CBSmoothScrollLayout.kCBAnimatedLayoutHeader)
        collectionView.register(Menu,
                                forSupplementaryViewOfKind: CBSmoothScrollLayout.kCBAnimatedLayoutMenu,
                                withReuseIdentifier: CBSmoothScrollLayout.kCBAnimatedLayoutMenu)
        collectionView.register(UINib(nibName: "Title", bundle: nil),
                                forSupplementaryViewOfKind: CBSmoothScrollLayout.kCBAnimatedLayoutTitle,
                                withReuseIdentifier: CBSmoothScrollLayout.kCBAnimatedLayoutTitle)
        if let title = UINib(nibName: "Title", bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView {
            title.sizeToFit()
            titleSize = title.frame.size
        }
    }
    
    
    

    lazy var addFoodVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFoodController") as! AddFoodController
    var dataList = DataManger.share.fetchAll()


    fileprivate func demoTip() {
        if self.dataList.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let cell = self.collectionView.cellForItem(at: IndexPath.init(row: 0, section: 0)) as? HomeCell {
                    cell.showSwipe(orientation: .right)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        cell.hideSwipe(animated: true)
                    })
                }
            }
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        styleCell()
//        demoTip()
//        self.wr_setNavBarShadowImageHidden(true)
//        self.wr_setNavBarBarTintColor(UIColor.clear)
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: DataManger.DataMangerDidSaveData, object: nil)
//
////        PushManager.share.addLocalNotification()
//    }
    
    @IBAction func didBeginAdding(_ sender: Any) {
        let popupController  = STPopupController.init(rootViewController: addFoodVC)
        popupController.containerView.layer.cornerRadius = 10
        let bgView = UIView.init()
        bgView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        popupController.backgroundView = bgView
        popupController.navigationBar.tintColor = UIColor.white
        popupController.navigationBar.barTintColor = UIColor.orange
        popupController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        popupController.present(in: self, completion: nil)
    }

    @objc fileprivate func reloadCollectionView() {
        self.dataList = DataManger.share.fetchAll()
        if dataList.count > 0 {
            collectionView.removeGestureRecognizer(emptyTableGesture)
        } else {
            collectionView.addGestureRecognizer(emptyTableGesture)
        }
        collectionView.reloadData()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        addFoodVC.isNext = false
//        addFoodVC.isNew = false
//        reloadCollectionView()
//    }

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomePageController: UICollectionViewSmoothScrollLayoutDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView: UICollectionReusableView
        switch kind {
        case CBSmoothScrollLayout.kCBAnimatedLayoutHeader:
            supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath)
        case CBSmoothScrollLayout.kCBAnimatedLayoutMenu:
            supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath)
            if let ss = supplementaryView as? MenuView {
                menu = ss
            }
        case CBSmoothScrollLayout.kCBAnimatedLayoutTitle:
            supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath)
            
        default:
            fatalError("unexpected element type")
        }
        
        
        if let animatableView = supplementaryView as? CBAnimatable {
            viewAnimator.register(animatableView: animatableView)
        }
        return supplementaryView
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
    var startDate: Date {
        return dateFormatter.date(from: "11:00") ?? Date()
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath)
        if let cell = cell as? TestCell {
            cell.lbl.text = dateFormatter.string(from: startDate.addingTimeInterval(TimeInterval(60*30*indexPath.item)))
            viewAnimator.register(animatableView: cell)
            cell.price.text = "$\(Int.random(in: 1...12) * 10)"
        }
        return cell
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, didUpdateAnimationTo progress: CGFloat) {
        viewAnimator.updateAnimation(toProgress: progress)
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, titleSizeForProgress progress: CGFloat) -> CGSize {
        return titleSize
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        menu.segmentView.reloadSegmentio()
        UIView.animate(withDuration: 0.1) {
            self.menu.segmentView.layoutIfNeeded()
        }
        
    }
}

//extension HomePageController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//        return dataList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
//        cell.data(with: dataList[indexPath.row])
//        cell.controlDelegate = self
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
////        let cell = collectionView.cellForItem(at: indexPath) as! HomeCell
//////        cell.showSwipe(orientation: .right, animated: true) { (_) in
//////
//////        }
////        cell.setSwipeOffset(10, animated: true) { (_) in
////
////        }
//
//    }
//}

extension HomePageController : HomeCellDelegate {
    func didClickDeleteWith(indexPath: IndexPath) -> Bool {
        let dataModel = self.dataList[indexPath.row]
        if let time = dataModel.importDate,DataManger.share.deleteWith(importDate: time)
        {
            self.reloadCollectionView()
            return true
            //                self.collectionView.deleteItems(at: [indexPath])
        } else {
            return false
        }
        
    }
}


extension HomePageController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return self.emptyMainView
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -80
    }
}

class HomeCell: SwipeCollectionViewCell {

    public weak var controlDelegate: HomeCellDelegate?
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var endDay: UILabel!
    @IBOutlet weak var during: UILabel!

    lazy var progress: LDProgressView = { [unowned self] in
        $0.animate = true
        $0.color = UIColor.red
        $0.flat = true
        $0.type = .stripes
        $0.progressInset = 1
        $0.background = UIColor.clear
        $0.showBackgroundInnerShadow = false
        $0.animateDirection = .backward
        $0.borderRadius = 2
        $0.outerStrokeWidth = 0
        $0.showStroke = false
        return $0
    }(LDProgressView())

    func data(with model: FoodDateModel) {
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
        
        if model.importDate == model.productDate {
            //滑动条
            //TODO crash
            let percent = 1 - (model.productDate?.timeIntervalSinceNow)!/model.duration
            progress.progress = CGFloat(percent)
        } else {
            let percent = 1 - (-(model.productDate?.timeIntervalSinceNow)!)/(model.expireDate?.timeIntervalSince(model.productDate!))!
            progress.progress = CGFloat(percent)
        }
        
        if model.importDate == model.productDate {
            endDay.text = model.importDate?.addingTimeInterval(model.duration).toFormat("yyyy年MM月dd日")
            during.text = (model.duration - (model.importDate?.timeIntervalSinceNow)!).toString()

        } else {
            endDay.text = model.expireDate?.toFormat("yyyy年MM月dd日")
            during.text = (model.duration - (model.importDate?.timeIntervalSinceNow)!).toString()
        }

    }

}

extension HomeCell: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { _, _ in
            let _ = self.controlDelegate?.didClickDeleteWith(indexPath: indexPath)
        }
        deleteAction.image = #imageLiteral(resourceName: "Trash-circle")
        deleteAction.backgroundColor = .white
        deleteAction.textColor = .red
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions
    {
        var options = SwipeOptions()
        options.expansionStyle =  .none
        options.transitionStyle = .border
        
        options.buttonSpacing = 4
        options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
        
        return options
    }
}

