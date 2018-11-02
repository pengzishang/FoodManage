//
//  AddExpirationController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/11/2.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import STPopup
import fluid_slider
import QMUIKit

class AddExpirationController: UIViewController {
    
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet var detailViews: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var btnHeight = (self.view.frame.width - 60 - 40)
        btnHeight = btnHeight * 3/26
        self.contentSizeInPopup = CGSize.init(width: self.view.frame.width - 40, height: btnHeight + 120)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.qmui_item(withTitle: "完成", target: self, action: #selector(didClickClose))
        let slider = Slider()
        slider.attributedTextForFraction = { fraction in
            return self.text(with: fraction)
        }
        let scale = self.view.frame.width/375
        let attrStr1 = NSMutableAttributedString.init(string: "0时")
        attrStr1.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11*scale),NSAttributedString.Key.foregroundColor:UIColor.white], range: NSRange.init(location: 0, length: "0时".count))
        let attrStr2 = NSMutableAttributedString.init(string: "13月")
        attrStr2.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11*scale),NSAttributedString.Key.foregroundColor:UIColor.white], range: NSRange.init(location: 0, length: "13月".count))
        slider.setMinimumLabelAttributedText(attrStr1)
        slider.setMaximumLabelAttributedText(attrStr2)
        slider.fraction = 0.33
        slider.shadowOffset = CGSize(width: 0, height: 5)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor.orange
        slider.valueViewColor = .white
        self.sliderView.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func didSwitchDetail(_ sender: UISwitch) {
        self.detailViews.forEach { $0.isHidden = !sender.isOn}
        if sender.isOn {
            self.contentSizeInPopup = CGSize.init(width: self.view.frame.width, height: 360)
        } else {
            var btnHeight = (self.view.frame.width - 60 - 40)
            btnHeight = btnHeight * 3/26
            self.contentSizeInPopup = CGSize.init(width: self.view.frame.width, height: btnHeight + 120)
        }
    }
    
    @objc fileprivate func didClickClose() {
        print("222")
    }
    
    private func text(with percent:CGFloat) -> NSAttributedString {
        let scale = self.view.frame.width/375
        var subPercent : CGFloat = 0
        var textPercent = ""
        if percent < 1/3 {
            subPercent = percent/(1/3)*24
            textPercent = Int(subPercent).description + "时"
        } else if percent >= 1/3 && percent < 1/3 * 2 {
            subPercent = (percent/(1/3) - 1)*30+1
            textPercent = Int(subPercent).description + "天"
        } else {
            subPercent = (percent/(1/3) - 2)*12+1
            textPercent = Int(subPercent).description + "月"
        }
        let attrStr = NSMutableAttributedString.init(string: textPercent)
        attrStr.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11*scale)], range: NSRange.init(location: 0, length: textPercent.count))
        return attrStr
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
