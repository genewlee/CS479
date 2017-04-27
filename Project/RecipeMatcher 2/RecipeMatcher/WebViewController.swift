//
//  WebViewController.swift
//  RecipeMatcher
//
//  Created by Gene Lee on 4/26/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class WebViewController: UIViewController {
    
    var url: URL!

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let wkWebView = WKWebView(frame: webView.frame)
//        let request = URLRequest(url: self.url!)
//        wkWebView.load(request)
//        self.view.addSubview(wkWebView)
        
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
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
