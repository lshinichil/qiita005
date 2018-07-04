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
    var N = 0
    var articles:[[String:String?]] = []
 //配列を入れる
    var testData: [String] = [
        "111",
        "222",
        "333",
        "444",
        "555",
        "666",
        "777",
        "888",
        "999",
        "100",
        ]
    
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
                    print(self.articles)
                    print(self.articles[0])
                    self.N = 1
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
        
        if N == 1 {
            let at = self.articles[indexPath.row]
            
            cell.titleLable?.text = at["title"] as? String
            cell.favoritedata.append(at)
            
        }else{
            cell.titleLable?.text=self.testData[indexPath.row]
        }
        //let articletext = articles[indexPath.row]
        //cell.textLabel?.text = articletext["title"]!
        //cell.detailTextLabel?.text = articletext["userId"]!
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        //URLの値を渡す
        next.data = self.articles[indexPath.row]["url"] as? String
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
