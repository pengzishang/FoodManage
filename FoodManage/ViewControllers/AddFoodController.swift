//
//  AddFoodController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/31.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import STPopup

class AddFoodController: UIViewController {
    
    lazy var addExpirationVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddExpirationController")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let photoHeight = (self.view.frame.width - 20 - 40) * 2448/3264
        self.contentSizeInPopup = CGSize.init(width: self.view.frame.width - 40, height: photoHeight + 120)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    
    
    @IBAction func didClickTakePhoto(_ sender: EasyButton) {
        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let takePhoto = UIImagePickerController.init(rootViewController: self)
//            takePhoto.delegate = self
//            self.present(takePhoto, animated: true) {
//                
//            }
//        } else {
//            //需要权限
//        }
        
//        let takePhoto = UIImagePickerController()
//        takePhoto.delegate = self
//        self.present(takePhoto, animated: true) {
//
//        }
//        self.contentSizeInPopup = CGSize.init(width: self.view.frame.width, height: 200)
        
        self.popupController?.push(addExpirationVC, animated: true)
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

extension AddFoodController :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
}
