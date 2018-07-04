//
//  WebViewController.swift
//  qiita005
//
//  Created by 井元進一 on 2018/06/26.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webViewController: UIWebView!
    var data: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAddressURL()
    }
    
    func loadAddressURL(){
        let requestURL = NSURL(string: data)
        let req = NSURLRequest(url: requestURL! as URL)
        webViewController.loadRequest(req as URLRequest)
        
        // Do any additional setup after loading the view.
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
