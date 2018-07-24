//
//  tableViewController.swift
//  qiita005
//
//  Created by 井元進一 on 2018/06/18.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var qiitaTableView: UITableView!
    
    
    let userDefaults = UserDefaults.standard
    var articles:[[String:String?]] = []
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.articles = []
        self.page = 1
        getArticles()
        self.qiitaTableView.delegate = self
        self.qiitaTableView.dataSource = self
        
        //xibファイルを呼び出す。
        let xib = UINib(nibName: "QiitaTableViewCell", bundle: nil)
        //xibファイルを登録する
        self.qiitaTableView.register(xib, forCellReuseIdentifier: "QiitaTableViewCell")
    }
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
            //articles.count
    }
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    //セルの中
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.qiitaTableView.dequeueReusableCell(withIdentifier:"QiitaTableViewCell", for: indexPath) as! QiitaTableViewCell
            let at = self.articles[indexPath.row]
            cell.favoritedata.append(at)
            cell.favoriteLabel?.text = at["title"] as? String
        
            //ボタンの編集
            cell.favoriteButtonLabel.setTitle("...", for: .normal)
        
            var favsum: [[String:String?]] = []
            if userDefaults.array(forKey: "favsum") != nil {
                favsum = userDefaults.array(forKey: "favsum") as! [[String : String?]]
            }
        
        
            var favdel: [[String:String?]] = []
            var favoritedata: [[String:String?]] = []
            //atをディクショナリ配列にする
            favoritedata.append(at)
        
            //削除対象を入れる
            favdel.append(contentsOf: favoritedata)
        
            //対象が既に配列にあるかを確認する
            let index = favsum.contains(favdel[0])
            //let index = favsum.contains(favoritedata[0])
            if index{
                cell.favoriteButtonLabel.setTitle(" - ", for: .normal)
            }else{
                cell.favoriteButtonLabel.setTitle(" + ", for: .normal)
            }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        //URLの値を渡す
        next.urldata = self.articles[indexPath.row]["url"] as? String
        show(next,sender: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticles(){
        Alamofire.request("https://qiita.com/api/v2/items?page=\(page)&per_page=10")
            .responseJSON{ response in
                guard let object = response.result.value else{
                    return
                }
                let json = JSON(object)
                json.forEach{
                    (_,json) in
                    let article : [String: String?] = [
                        "title":json["title"].string,
                        "userId":json["user"]["id"].string,
                        "url":json["url"].string
                    ]
                    
                    self.articles.append(article)
                    self.qiitaTableView.reloadData()
                }
        }
        
    }

    @IBAction func rightSwipeGestureRecognizer(_ sender: UISwipeGestureRecognizer) {
        if page < 10{
            self.page += 1
        }
        self.articles = []
        getArticles()
    }
    
    @IBAction func leftSwipeGestureRecognizer(_ sender: UISwipeGestureRecognizer) {
        if page > 0{
            self.page -= 1
        }
        self.articles = []
        getArticles()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
