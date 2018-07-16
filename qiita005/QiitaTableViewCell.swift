//
//  QiitaTableViewCell.swift
//  qiita005
//
//  Created by 井元進一 on 2018/06/20.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class QiitaTableViewCell: UITableViewCell { 
   
    //TableViewControllerから取得
    var favoritedata: [[String:String?]] = []
    var favdel: [[String:String?]] = []
    let userDefaults = UserDefaults.standard

    //UIdata

    
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteButtonLabel: UIButton!
    @IBAction func favoriteButton(_ sender: Any) {
        
        var favsum: [[String:String?]] = userDefaults.array(forKey: "favsum") as! [[String : String?]]
        
        var favdel: [[String:String?]] = []
        
        //favdel 削除対象の値を入れる
        favdel.append(contentsOf: favoritedata)
        
        //対象が既に配列にあるのかを確認する
        let index = favsum.contains(favdel[0])
        let indexdel = favsum.index(of: favdel[0])
        
        if index{
        //対象を削除
            favsum.remove(at: indexdel!)
            favoriteButtonLabel.setTitle(" + ", for: .normal)
        }else {
        //対象を追加
            favsum.append(contentsOf: favoritedata)
            favoriteButtonLabel.setTitle(" - ", for: .normal)
        }
        //お気に入りのニュースをユーザーデフォルトに保存する。
        userDefaults.set(favsum,forKey:"favsum")
        //永続保存
        userDefaults.synchronize()
        favoritedata = []
        
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
