//
//  FavoriteViewController.swift
//  qiita005
//
//  Created by 井元進一 on 2018/06/26.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var favoriteWebView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoriteWebView.delegate = self
        self.favoriteWebView.dataSource = self
        
        //xibファイルを呼び出す。
        let xib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        //xibファイルを登録する
        self.favoriteWebView.register(xib, forCellReuseIdentifier: "FavoriteTableViewCell")
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.favoriteWebView.dequeueReusableCell(withIdentifier:"FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        
        return cell
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
