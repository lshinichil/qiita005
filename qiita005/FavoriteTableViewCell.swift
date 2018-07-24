//
//  FavoriteTableViewCell.swift
//  qiita005
//
//  Created by 井元進一 on 2018/06/26.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    //TableViewControllerから取得
    
    var favoritedata: [[String:String?]] = []
    var favindex = 0
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var favoriteButtonLabel: UIButton!
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        var favsum: [[String: String?]] = []

            if nil != userDefaults.array(forKey: "favsum"){
                favsum = userDefaults.array(forKey: "favsum") as! [[String : String?]]
            }
        
        favsum.remove(at:favindex)
        //お気に入りのニュースをユーザーデフォルトに保存する。
        userDefaults.set(favsum,forKey:"favsum")
        //永続保存
        userDefaults.synchronize()
        //ここで更新したい。
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
