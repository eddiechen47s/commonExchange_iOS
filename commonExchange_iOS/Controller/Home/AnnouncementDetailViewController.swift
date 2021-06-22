//
//  AnnouncementDetailViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/19.
//

import UIKit
import WebKit

class AnnouncementDetailViewController: UIViewController {
    
    private let contentView = BaseView(color: .white)
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    private let titleLabel = BaseLabel(text: "KTrade 數位資產交易所 公告", color: .black, font: .systemFont(ofSize: 22, weight: .bold), alignments: .center)
    private lazy var timeLabel = BaseLabel(text: "修改於 "+self.timeToTimeStamp(time: String(infoList!.addtime)), color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .center)
    
    let webView = WKWebView()
    var infoList: ListModel!
    
    init(infoList: ListModel) {
        self.infoList = infoList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupWebView()
    }
    
    private func setupWebView() {
        
        self.webView.navigationDelegate = self
        self.webView.isOpaque = false
        self.webView.backgroundColor = .white
        self.webView.tintColor = .orange
        self.webView.scrollView.backgroundColor = .clear
        
//        guard let htmlData = infoList?.contentCt else { return }
//        print(infoList.contentCt!)
        
//        let htmls = """
//        <html>
//        <head>
//        <meta name="viewport", content="width=device=width, initial-scale=0.6">
//        <style> body { color:white; } </style>
//        <style> head { color:white; } </style>
//        <head>
//        <body>
//
//        <class=\(infoList.contentCt!)></class>
//
//        <body>
//        <html>
//        """
        
        //<div bgcolor ="#rrggbb">
//        webView.loadHTMLString(htmls, baseURL: nil)
        webView.loadHTMLString("<head><meta charset='utf-8'><meta name='viewport' content='width=device=width, initial-scale=0.5, shrink-to-fit=no'><meta name='theme-color' content='#000000'><meta name='viewport' content='width=device-width, initial-scale=0.5, maximum-scale=0.5, user-scalable=0' /><meta name='theme-color' content='#5A9C14'><meta name='msapplication-navbutton-color' content='#5A9C14'><meta name='apple-mobile-web-app-status-bar-style' content='#5A9C14'><link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'><style>:root,* {font-family: 'Roboto', sans-serif;font-size: 14px;color: rgb(114, 114, 114);text-align: justify;-webkit-user-select: none;user-select: none;}</style></head><body>\(infoList.contentCt!)</body>", baseURL: nil)
    }
    
    private func setupUI() {
        view.addSubViews(contentView, webView)
        contentView.addSubViews(titleLabel, timeLabel, bottomView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(4)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(view.snp.bottom)
        }
    }

}

extension AnnouncementDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
//        webView.evaluateJavaScript("document.getElementsByTagName('blockquote')[0].style.webkitTextSizeAdjust= '250%'", completionHandler: nil)
//        print(webView)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
    }
}
