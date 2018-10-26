//
//  HomePageController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/25.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import Schedule
import LDProgressView
import SnapKit

class HomePageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        PushManager.share.addLocalNotification()
        
        
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

extension HomePageController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.data()
        return cell
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
        progress.type = LDProgressStripes
        progress.progressInset = 1
        progress.background = UIColor.white
        progress.showText = false
        progress.showBackgroundInnerShadow = false
        progress.outerStrokeWidth = 0
        progress.borderRadius = 3
        self.progressView.addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    

}
