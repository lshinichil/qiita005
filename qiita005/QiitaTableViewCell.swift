//
//  QiitaTableViewCell.swift
//  qiita005
//
//  Created by 井元進一 on 2018/06/20.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class QiitaTableViewCell: UITableViewCell {
    
    var favoritedata: [[String:String?]] = []
    let userDefaults = UserDefaults.standard

    
    @IBOutlet weak var titleLable: UILabel!
    @IBAction func favoriteButton(_ sender: Any) {
        
        //favsomはお気に入りのニュース
        var favsum: [[String:String?]] = userDefaults.array(forKey: "favsum") as! [[String : String?]]
        var favdel: [[String:String?]] = []
        
        //favdel 削除対象の値を入れる
        favdel.append(contentsOf: favoritedata)
        
        //対象が既に配列にあるのかを確認する
        let index = favsum.contains(favdel[0])
        let indexdel = favsum.index(of: favdel[0])
        if index{
        //対象を削除
        print(indexdel!)
            
        favsum.remove(at: indexdel!)
            
        
        //出ちゃいます。。。。。
            //
            
        }else {
        //対象を追加
        favsum.append(contentsOf: favoritedata)
        }
        print(" \(favsum)")
   
  //////////////////////////
        ////favsumの中を検索して押したボタンのテーブルと一致するか確認する。
        ////////////////////////

        print(index)
        //favsum.contains("title"[String : String?])
        print(titleLable.text!)
        
        
        
        //お気に入りのニュースをユーザーデフォルトに保存する。
        userDefaults.set(favsum,forKey:"favsum")
        
        //永続保存
        userDefaults.synchronize()
        
        let test: [[String:String?]] = userDefaults.array(forKey: "favsum") as! [[String : String?]]
        /////↑ここを配列で保存にしたい。
        print(test)
        print(test[0])
        
        
        ////////////////////////////////////////
        //ユーザーデフォルトにお気に入りボタンを押した際に保存したい
        //タイトル　URL ユーザー名の配列を作り　それぞれに登録するしかない？
        ////////////////////////////////////////
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
