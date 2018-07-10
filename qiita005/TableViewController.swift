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

    var articles:[[String:String?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArticles()
        self.qiitaTableView.delegate = self
        self.qiitaTableView.dataSource = self
        
        //xibファイルを呼び出す。
        let xib = UINib(nibName: "QiitaTableViewCell", bundle: nil)
        //xibファイルを登録する
        self.qiitaTableView.register(xib, forCellReuseIdentifier: "QiitaTableViewCell")
        // Do any additional setup after loading the view.

    }
    
    func getArticles(){
        Alamofire.request("https://qiita.com/api/v2/items")
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
                    // print("\(self.articles[0]["title"] as? [String:Any])")
                    let titletext : String = json["title"].stringValue
                    let usertext : String = json["user"]["id"].stringValue
                    
                    print(" \(article)")
                    print("タイトルを表示 \(titletext)")
                    print("ユーザー名\(usertext)")
  
                    self.qiitaTableView.reloadData()
                }
        }
        
    }
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    //セルの中
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.qiitaTableView.dequeueReusableCell(withIdentifier:"QiitaTableViewCell", for: indexPath) as! QiitaTableViewCell
        
            let at = self.articles[indexPath.row]
            cell.titleLable?.text = at["title"] as? String
            cell.favoritedata.append(at)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
