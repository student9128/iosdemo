//
//  BaseViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/25.
//

import Foundation
import UIKit
class BaseViewController:UIViewController{
    var mTitleLabel:UILabel?
    override func viewWillAppear(_ animated: Bool) {
        let color=setStatusBar()
        self.navigationController?.navigationBar.backgroundColor = color
        UIApplication.statusBarUIView?.backgroundColor=color
        self.navigationController?.navigationItem.title="hello"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    
//        mTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
//        setTitleAttrs(mTitleLabel!)
//        self.navigationController?.navigationItem.titleView=mTitleLabel
        
//         Add the label as a subview of the navigation bar
//        self.navigationController?.navigationBar.addSubview(mTitleLabel!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="hello"
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    func setStatusBar()->UIColor{
        return UIColor.systemTeal
    }
    func setTitleAttrs(_ title:UILabel){
        mTitleLabel?.text = "iOSDemo"
        mTitleLabel?.textColor=UIColor.white
        mTitleLabel?.textAlignment = .center
    }
}
