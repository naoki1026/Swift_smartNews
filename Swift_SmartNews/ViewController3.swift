//
//  ViewController2.swift
//  Swift_SmartNews
//
//  Created by Naoki Arakawa on 2019/03/06.
//  Copyright © 2019 Naoki Arakawa. All rights reserved.
//

import UIKit
import Firebase

//これによってボタンをカラフルにすることができる
import DTGradientButton

class ViewController3: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var refleshBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    //String型のものが中に入る配列をarrayと定義している
    //var array = [String]()
    
    //ここのPostがPostクラスを意味しており、
    //Postクラス型の配列を定義している
    var posts = [Post]()
    
    //Postクラスの宣言している
    var postBox = Post()
    
    //タップされたセルの番号を取得する
    var selectedNumber = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //ここでボタンにグラデーションをかけている
        refleshBtn.setGradientBackgroundColors([UIColor(hex: "FF8960"), UIColor(hex: "FF62A5")], direction: .toRight, for: .normal)
        
        //枠線を角丸にする
        refleshBtn.layer.cornerRadius = refleshBtn.frame.height/2
        
        //角丸で囲まれた部分以外を非表示にする
        refleshBtn.layer.masksToBounds = true
        
    }
    
    //UIKitの中に入っているメソッドとなっている
    override func viewWillAppear(_ animated: Bool) {
        
        //毎回記事が更新されるたびに記事更新ボタンを押すのは都合が悪い
        super.viewWillAppear(animated)
        fetchPosts()
        tableView.reloadData()
    }
    
    // セルの数を決定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    //セクションの数を決定する
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //セルをプログラムで認識させる、ここはセルが増えるたびに呼ばれる
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let titleLabel = cell.viewWithTag(1) as! UILabel
        
        //titlelabelのtextに反映したいのはPostクラスのタイトルである
        //selfのPostsというのは、 var posts = [Post]()のことで、Postクラスが入る配列である
        //配列の何番めを取ってくるのかというのが、idenxPathのrow番目で、２つあるうちのtitleを返却してくださいというコード
        titleLabel.text = self.posts[indexPath.row].title
        
        return cell
        
        
    }
    
    //セルがタッチされた時に呼ばれるメソッドである
    //ここでタッチされたセルを出す
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //何番目のセルがタップされたかを取得する
        selectedNumber = indexPath.row
        
        //セルがタップされたときにハイライトを消す（定型文）
        if let indexPathRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathRow, animated: true)
            
        }
        
        //画面遷移を行う
        performSegue(withIdentifier: "webView", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "webView" {
            
            //WebViewControllerを変数にしている、値を渡しながら画面遷移をする際に必要になっている
            let webVC: WebViewController = segue.destination as! WebViewController
            webVC.newsURL = self.posts[selectedNumber].newsURL
            
            
            
        }
        
    }
    
    //Firebaseからデータを取得する際のメソッド
    //Firebaseからデータを受け取るための配列とクラスを空にする
    func fetchPosts() {
        
        //図の青色、配列の部分を初期化
        self.posts = [Post]()
        
        //クラスの部分を初期化
        self.postBox = Post()
        
        //参照するデータベースのURLを取得
        //データベースを取得するための初期化
        //GoogleService~.plistを定義しているためrefと入れるだけでOK
        let ref = Database.database().reference()
        
        //最新の何件を取ってくるのかということを定義している、ここでは10件
        ref.child("post2").queryLimited(toLast: 10).observeSingleEvent(of: .value) { (snap,error) in
            
            //取得されたものが全てsnapの中に入ってくるが、snapの中身がstring型とNSDictionary型に分かれている
            //Postクラスは全てString型で、中身は辞書型である
            let postsSnap = snap.value as? [String : NSDictionary]
            
            if postsSnap == nil {
                
                //このreturnは何も返さなくていいよということを意味している
                return
                
            }
            
            //postBoxになっていた
            self.posts = [Post]()
            
            //_はワイルドカードと言って、postsSnapの中身をpostの中に入れてくださいということを言っている
            //これはfor文
            for (_,post) in postsSnap! {
                
                self.postBox = Post()
                
                //まずはpostのtitleというところを取ってきてください、それはString型で、postのnewsURLをString型で、
                //取ってきてくださいと、取ってきたものはtitleとnewsURLに入ってくるが、このtitleとnewsURLはpostBoxに
                //そのまま入れてくださいということをここでは書いている
                if let title  = post["title"] as? String,let newsURL = post["newsURL"] as? String {
                    
                    self.postBox.title = title
                    self.postBox.newsURL = newsURL
                    
                }
                
                //postBoxのタイトルの中に新規のタイトルを入れてください
                //クラスをまとめて、配列の中に入れてください
                self.posts.append(self.postBox)
                
            }
            
            //費用なデリゲートメソッドが呼ばれる
            self.tableView.reloadData()
            
        }
    }
    
    //セルの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
        
    }
    
    
    @IBAction func reflesh(_ sender: Any) {
        
        //データを取ってきたいので、fetchpostsを呼び出せばよい
        fetchPosts()
        
    }
    
    
    
}

