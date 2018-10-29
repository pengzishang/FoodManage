//
//  AskPermissionController.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/29.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit
class AskPermissionController: UIViewController {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftSubTitle: UILabel!
    @IBOutlet weak var demoView: UIView!
    @IBOutlet weak var activitedAsking: EasyButton!
    @IBOutlet weak var laterAsking: UIButton!
    
    var player = AVPlayer.init(url: Bundle.main.url(forResource: "Demo", withExtension: "mov")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let layer = AVPlayerLayer.init(player: player)
        layer.frame = self.demoView.layer.bounds
        self.demoView.layer.addSublayer(layer)
        self.player.play()
    }
    
    @IBAction func didClickCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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

