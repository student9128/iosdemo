//
//  SecondViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/9.
//

import Foundation
import UIKit

class SecondViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.lightGray
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.toolbar.backgroundColor=UIColor.red
//        let tb=toolbarItems
//        let view1 = UIView.init(frame: CGRectMake(0, 0, 100, 44))
        let b1=UIBarButtonItem.init(title: "Hello", style: UIBarButtonItem.Style.done, target: self, action:#selector(b1Click))
        b1.tintColor=UIColor.green
        b1.isHidden=false
        b1.tag=1

        let b2=UIBarButtonItem.init(systemItem:UIBarButtonItem.SystemItem.add)
//        self.navigationController?.toolbarItems=[b1,b2]
//        self.navigationController?.hidesBottomBarWhenPushed=false
        self.setToolbarItems([b1,b2], animated: true)
     
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("second will Disappear")
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("second did Disappear")
    }
    @objc func b1Click(){
        print("btn1")
    }
    @objc func b2Click(){
        print("btn2")
    }
    
}
