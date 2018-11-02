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

class HomePageController: UIViewController {
    
    @IBOutlet var emptyMainView: UIView!
    @IBOutlet var emptyTableGesture: UITapGestureRecognizer!
    
    lazy var addFoodVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFoodController")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.showEmptyView(withText: "天哪,干干净净,难道冰箱里面没东西吗?", detailText: "", buttonTitle: "开始添加!", buttonAction: #selector(didBeginAdding(_:)))
//        let image = UIImageView.init(image: UIImage.init(named: "basket"))
////        1067:829
//        image.qmui_sizeToFitKeepingImageAspectRatio(in: CGSize.init(width: self.view.frame.width/375*72, height: self.view.frame.width/375*72*829/1067))
//        let btn = QMUIFillButton.init(fill: UIColor.blue, titleTextColor: UIColor.white)
//        btn.setTitle("开始添加!", for: .normal)
//
//        self.showEmptyView()
//        self.showEmptyView(with: UIImage.init(named: "basket"), text: "天哪,干干净净,难道冰箱里面没东西吗?", detailText: "", buttonTitle: "开始添加!", buttonAction: #selector(didBeginAdding(_:)))
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomePageController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
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


class HomeCell: UITableViewCell {
    @IBOutlet weak var progressView: UIView!
    
    func data() {
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
