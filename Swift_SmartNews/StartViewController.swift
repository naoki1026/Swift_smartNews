//
//  StartViewController.swift
//  Swift_SmartNews
//
//  Created by Naoki Arakawa on 2019/03/06.
//  Copyright © 2019 Naoki Arakawa. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    //パララックスでデバイスを傾けることを考慮して、ラベルもつなぐ
    //その他のパーツも一緒につなぐ
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //画面を傾けた時にどれだけ動くかどうかを定義しているのがカッコの中
        //パララックスに関する定義を行なっている（GitHub参照）
        //https://github.com/UIxUX/SimpleParallax
        
        //backgroundに対するパララックスの設定
        background.addBackgroundPxEffect(strength: .Mid)
        
        //titleLabelに対するパララックスの設定
        titleLabel.addMiddlegroundPxEffect()
        
        //buttonに対するパララックスの設定
        startButton.addForegroundPxEffect(strength: .High)
        
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
