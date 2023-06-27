//
//  Test.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/17.
//

import Foundation
import UIKit
class Test:BaseViewController,UIScrollViewDelegate{
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建scrollView和imageView
            scrollView = UIScrollView(frame: view.bounds)
//            imageView = UIImageView(image: UIImage(named: "example_image"))
        let btn=UIButton(type: .system)
        btn.frame=CGRect(x: 0, y: 100, width: 100, height: 100)
        btn.setTitle("测试画中画", for: .normal)
        btn.backgroundColor=UIColor.purple
        btn.addTarget(self, action: #selector(goTest), for: .touchUpInside)
            
            // 设置scrollView的内容大小和缩放比例
            scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
            scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            scrollView.delegate = self
//            scrollView.maximumZoomScale = 3.0
//            scrollView.minimumZoomScale = 1.0
            
            // 将imageView添加到scrollView中
            scrollView.addSubview(btn)
            view.addSubview(scrollView)
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.statusBarUIView?.backgroundColor=UIColor.red
        self.navigationController?.navigationBar.backgroundColor=UIColor.red
        self.navigationController?.navigationBar.topItem?.title = "TestX"
    }
    @objc func goTest(){
        let v = SevenViewController()
        self.navigationController?.pushViewController(v, animated: true)
    }
}
