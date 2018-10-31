//
//  HomePageController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/25.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import zhPopupController
import SnapKit

class HomePageController: UIViewController {
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet var emptyTableGesture: UITapGestureRecognizer!
    
    lazy var addFoodVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFoodController")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        PushManager.share.addLocalNotification()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didBeginAdding(_ sender: Any) {
        self.zh_popupController.layoutType = .center
        self.zh_popupController.slideStyle = .fromBottom
//        self.zh_popupController.allowPan = true
        self.zh_popupController.maskAlpha = 0.2
        self.addFoodVC.view.frame  = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 500)
        self.zh_popupController.presentContentView(self.addFoodVC.view, duration: 0.5, springAnimated: true)
        
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
        return self.emptyView
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -50
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
