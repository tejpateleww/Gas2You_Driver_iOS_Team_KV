//
//  WebViewVC.swift
//  Clotheslyners
//
//  Created by Tej on 11/02/21.
//

import UIKit
import WebKit

class WebViewVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var viewWeb: WKWebView!
    
    //MARK:- VAriables and Properties
    var strUrl : String = "https://www.google.com"
    var isLoadFromURL :Bool = false
    
    //MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewWeb.navigationDelegate = self
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Invoice", leftImage: "Back", rightImages: [], isTranslucent: true)

        if(isLoadFromURL){
            self.LoadFromURL(strUrl: strUrl)
        }else{
            self.LoadFromHTML(strUrl: strUrl)
        }
       
    }
    
    func LoadFromURL(strUrl : String){
        let url = URL(string: strUrl)
        let requestObj = URLRequest(url: url! as URL)
        viewWeb.load(requestObj)
    }
    
    func LoadFromHTML(strUrl : String){
        let htmlString = strUrl
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        viewWeb.loadHTMLString(headerString + htmlString, baseURL: nil)
    }
}

extension WebViewVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //Utility.showHUD()
        //self.Activity.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //Utility.hideHUD()
        //self.Activity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //Utility.hideHUD()
       // self.Activity.stopAnimating()
    }
    
}
