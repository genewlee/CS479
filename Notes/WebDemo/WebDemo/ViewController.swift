//
//  ViewController.swift
//  WebDemo
//
//  Created by Gene Lee on 3/21/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

class ViewController: UIViewController {
    
    let urlString = "http://www.eecs.wsu.edu/~holder/courses/MAD/"
    
    @IBOutlet weak var uiWebView: UIWebView!
    @IBAction func uiWebViewTapped(_ sender: UIButton) {
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        uiWebView.loadRequest(request)
    }
    
    @IBOutlet weak var wkWebSubView: UIView!
    @IBAction func wkWebViewTapped(_ sender: UIButton) {
        let wkWebView = WKWebView(frame: wkWebSubView.frame)
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
    }
    
    @IBAction func safariTapped(_ sender: UIButton) {
        let url = URL(string: urlString)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

