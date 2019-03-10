//
//  ViewController.swift
//  Swift_SmartNews
//
//  Created by Naoki Arakawa on 2019/03/06.
//  Copyright © 2019 Naoki Arakawa. All rights reserved.
//

import UIKit

//AMPagerViewControllerと入力することで、ここがベースに
//なりますよということを定義している
class ViewController: AMPagerTabsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //仮にこれらが定義されていなかった場合はストーリーボードの色が優先
        //上に表示されているバーの上の部分の色を定義
        settings.tabBackgroundColor = UIColor.green
        
        //上に表示されているバーの下の部分（タブ）の色を定義
        settings.tabButtonColor = UIColor.green
        
        //タブのフォントを定義している
        tabFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        
       //後からgetTabs関数を作成する
        self.viewControllers = getTabs()
        
    }
    
    //これでUIViewController型の配列を返す必要がある
    //つまりどの画面のタブとして今回定義するのかということを配列形式で返す必要がある
    //ベースの画面から見た時に、どれが２、３、４なのかということを定義してあげる
    func getTabs() -> [UIViewController]{
        
        let viewController2 = self.storyboard?.instantiateViewController(withIdentifier: "viewController2")
        let viewController3 = self.storyboard?.instantiateViewController(withIdentifier: "viewController3")
        let viewController4 = self.storyboard?.instantiateViewController(withIdentifier: "viewController4")
        
        //タブの名前
        viewController2?.title = "本日のトピック"
        viewController3?.title = "エンタメ動画"
        viewController4?.title = "おもしろ"
        
        return [viewController2!, viewController3!, viewController4!]
        
    }


}

