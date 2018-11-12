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
import IBAnimatable

class AddExpirationController: UIViewController {

    @IBOutlet weak var sliderView: UIView!
    @IBOutlet var detailViews: [UIView]!
    var startDate: Date?
    var endDate: Date?
    @IBOutlet weak var startBtn: AnimatableButton!
    @IBOutlet weak var endBtn: AnimatableButton!
    
    fileprivate lazy var slider:Slider = { [unowned self] in
        $0.attributedTextForFraction = { fraction in
            return self.text(with: fraction)
        }
        let scale = self.view.frame.width/375
        let attrStr1 = NSMutableAttributedString.init(string: "0时")
        attrStr1.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11*scale), NSAttributedString.Key.foregroundColor: UIColor.white], range: NSRange.init(location: 0, length: "0时".count))
        let attrStr2 = NSMutableAttributedString.init(string: "13月")
        attrStr2.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11*scale), NSAttributedString.Key.foregroundColor: UIColor.white], range: NSRange.init(location: 0, length: "13月".count))
        $0.setMinimumLabelAttributedText(attrStr1)
        $0.setMaximumLabelAttributedText(attrStr2)
        $0.fraction = 0.33
        $0.shadowBlur = 5
        $0.contentViewColor = UIColor.orange
        $0.valueViewColor = .white
       return $0
    }(Slider())

    override func awakeFromNib() {
        super.awakeFromNib()
        var btnHeight = (self.view.frame.width - 60 - 40)
        btnHeight = btnHeight * 3/26
        self.contentSizeInPopup = CGSize.init(width: self.view.frame.width - 40, height: btnHeight + 120)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.qmui_item(withTitle: "完成", target: self, action: #selector(didClickClose))
        
        self.sliderView.addSubview(self.slider)
        self.slider.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func didSwitchDetail(_ sender: UISwitch) {
        self.detailViews.forEach { $0.isHidden = !sender.isOn}
        var btnHeight = (self.view.frame.width - 60 - 40)
        btnHeight = btnHeight * 3/26
        if sender.isOn {
            self.contentSizeInPopup = CGSize.init(width: self.view.frame.width, height: btnHeight + 300)
        } else {
            self.contentSizeInPopup = CGSize.init(width: self.view.frame.width, height: btnHeight + 120)
        }
    }

    @IBAction func didClickProductTime(_ sender: Any) {
        let dialog = DatePickerDialog.init(buttonColor: .black, showCancelButton: true)
        dialog.show("生产时间", doneButtonTitle: "完成", cancelButtonTitle: "取消", defaultDate: self.endDate ?? self.startDate ?? Date.init(), minimumDate: self.startDate ?? Date.init(), maximumDate: nil, datePickerMode: .date) { (date) in
            if date != nil {
                self.startDate = date
                self.startBtn.setTitle(date!.toFormat("yyyy年 MM月 dd日 生产"), for: .normal)
            }
        }
    }

    @IBAction func didClickExpiredTime(_ sender: Any) {
        let dialog = DatePickerDialog.init(buttonColor: .black, showCancelButton: true)
        dialog.show("到期时间", doneButtonTitle: "完成", cancelButtonTitle: "取消", defaultDate: self.endDate ?? self.startDate ?? Date.init(), minimumDate: self.startDate ?? Date.init(), maximumDate: nil, datePickerMode: .date) { (date) in
            if date != nil {
                self.endDate = date
                self.endBtn.setTitle(date!.toFormat("yyyy年 MM月 dd日 到期"), for: .normal)
            }
        }
    }

    @objc fileprivate func didClickClose() {
        self.popupController?.dismiss(completion: {
            DataManger.share.currentModel.expireDate = self.endDate
            DataManger.share.currentModel.productDate = self.startDate
            DataManger.share.currentModel.duration = self.time(with: self.slider.fraction)
            DataManger.share.currentModel.importDate = Date.init()
            DataManger.share.currentModel.isExpired = false
            DataManger.share.insertFood()
            //TODO:储存动作

        })
    }

    fileprivate func text(with percent: CGFloat) -> NSAttributedString {
        let scale = UIScreen.main.bounds.width/375
        var subPercent: CGFloat = 0
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
        attrStr.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11*scale)], range: NSRange.init(location: 0, length: textPercent.count))
        return attrStr
    }

    fileprivate func time(with percent: CGFloat) -> TimeInterval {
        if percent < 1/3 {
            return TimeInterval(24*3600*percent)
        } else if percent >= 1/3 && percent < 1/3 * 2 {
            let days = (percent/(1/3) - 1)*30 + 1
            return TimeInterval(days*24*3600)
        } else {
            let months = (percent/(1/3) - 2)*12 + 1
            return TimeInterval(months*30*24*3600)
        }
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
