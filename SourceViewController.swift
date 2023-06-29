//
//  SourceViewController.swift
//  MealsAndDrinksApp
//
//  Created by Marko Zivanovic on 29.12.22..
//

import UIKit
import WebKit
import Kingfisher
import Alamofire
import SwiftyJSON

class SourceViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var sourceSiteDetail: [Meals] = []
    var selectedSourceDetail: Meals?
    var source: Meals!
    
    override func loadView() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //presentSourceSite()
        selectSource()
    }
    
    func selectSource() {
        title = source?.strSource
        if let url = URL(string: source?.strSource ?? "") {
            webView.load(URLRequest(url: url))
        }
    }
}
























