//
//  Test.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/17.
//

import Foundation
import UIKit
class Test:BaseViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.statusBarUIView?.backgroundColor=UIColor.red
        self.navigationController?.navigationBar.backgroundColor=UIColor.red
        self.navigationController?.navigationBar.topItem?.title = "Test"
    }
}
