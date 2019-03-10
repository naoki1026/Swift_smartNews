//
//  ViewController.swift
//  SwiftWKWebView
//
//  Created by Naoki Arakawa on 2019/02/18.
//  Copyright © 2019 Naoki Arakawa. All rights reserved.
//

import UIKit
import WebKit


//WKNavigationDelegateを追加する
//インディケーターを使用する場合に、WKNaigationDelegateを追加する
class WebViewController: UIViewController, WKNavigationDelegate {
    
    
    //イニシャライズしている
    var newsURL: String! = String()
    
    @IBOutlet weak var toolBar: UIToolbar!
    //各種ボタンを設置
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var nextBtn: UIBarButtonItem!
    @IBOutlet weak var refleshBtn: UIBarButtonItem!
    
    //WKWebViewを定義する
    var webView : WKWebView!
    
    //var urlString : String = "https://www.1101.com/home.html"
    //URLを空の状態にしておく
    //var urlString : String = ""
    
    //インディケーターを定義しておく
    var indicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //WKWebViewを作成
        //間違い！ここが登録されていなかった
        setWKWebView()
        
        //インディケータを呼ぶ
        setIndicator()
        
        //ボタンの設定
        //canGoBackとcanGoForwardがtrueだったらそれぞれのボタンを使えるように「
        //してくださいということをここでは定義している
        //使用できない場合は灰色になってしまう
        backBtn.isEnabled = webView.canGoBack
        nextBtn.isEnabled = webView.canGoForward
        
        //WKWebViewに別の画面に遷移するためのリンクがある場合に遷移できるように
        //することを許可している
        //ここをfalseにすると表示されなくなる
        webView.allowsLinkPreview = true
        
        //guard let url = URL (string: newsURL) else {
            
           //return
        }
        
    
    
    //ここでやりたいことはURLをロードすること
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //空の状態を許さないためguardを使う
        guard let url = URL(string: newsURL) else{
            return
            
        }
        
        //サイトを写すときにキャシュととっていく
        //同じものを開くときに100秒以内であればそのキャッシュを元に表示することができる
        //ユーザーエクスペリエンスの部分で高速化しているように見せることができる
        let req = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 100)
        
        self.webView.load(req)
        
    }
    
    //WKWebViewを定義するための関数を定義する
    func setWKWebView(){
        
        //viewの全体を指している
        //XとYが0,0で、フレームいっぱいに広がっているものが入っている
        var frame = view.bounds
        
        //これをwebViewに反映していく
        //ステータスバーとナビゲーションバーとツールバーを除いた高さを高さとして定義している
        frame.size.height = frame.height - UIApplication.shared.statusBarFrame.height - (navigationController?.navigationBar.frame.height ?? 0) - toolBar.frame.height
        
        //WKWebViewに上記frameのサイズを反映する
        webView = WKWebView(frame: frame)
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        
    }
    
    func setIndicator() {
        
        //インディケーターの初期化を行わなくてはいけない
        indicator = UIActivityIndicatorView()
        
        
        //サイズを決定する
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        
        //アニメーションが止まっている時の表示
        indicator.hidesWhenStopped = true
        
        //indicatorの色について
        indicator.style = .gray
        
        //WebViewにaddSubView
        self.webView.addSubview(indicator)
        
    }
    
    //これはこういうものだと理解する
    //URLの読み込みを許可するかしないかを決定できるメソッド
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
    }
    
    //通信が開始したタイミングで呼ばれる
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        //インディケーターを回したい
        indicator.startAnimating()
        
    }
    
    //通信が完了したタイミングで呼ばれる
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        indicator.stopAnimating()
    }
    
    //backボタンの設定
    @IBAction func back(_ sender: Any) {
        
        //前の画面に戻る
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.webView.goBack()
        
    }
    
    
    @IBAction func tapNext(_ sender: Any) {
        
        self.webView.goForward()
        
    }
    
    
    @IBAction func tapReflesh(_ sender: Any) {
        
        self.webView.reload()
        
    }
    
    
}


/* 二重で書かれていた
//ここからロードしていく
///returnCacheDataElseLoadはキャッシュがあれば通信を行わずに更新できる
let req = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 100)

//ここでリクエストをして表示されるようになる
self.webView.load(req)



}

// */
