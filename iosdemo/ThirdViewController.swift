//
//  ThirdViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/13.
//

import Foundation
import UIKit
import SnapKit
class ThirdViewController :ViewController{
    override func viewDidLoad() {
        if #available(iOS 13.0, *){
            let window:UIWindow?=UIApplication.shared.windows.first
            let sh=window?.windowScene?.statusBarManager?.statusBarFrame.height
            let bottom=window?.safeAreaInsets.bottom
            print("sh=\(sh),bottom=\(String(describing: bottom))")
        }
        let name=UIDevice.current.name
        print("name=\(name)")
        
        let tabHeight=UIDevice.vg_tabBarHeight()
        let tabFullH=UIDevice.vg_tabBarFullHeight()
        let navBarHeight=UIDevice.vg_navigationBarHeight()
        let navFullH=UIDevice.vg_navigationFullHeight()
    print("tabHeight=\(tabHeight)，tabFull=\(tabFullH),navH=\(navBarHeight),navFullH=\(navFullH)")
       
        let btn = UIButton()
        btn.backgroundColor=UIColor.systemRed
        btn.setTitle("测试snapKit", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(btn)
        btn.snp.makeConstraints({(make) in
//            make.width.height.equalTo(50)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.left.equalTo(20)
            make.top.equalTo(200)
//            make.center.equalTo(self.view)
        })
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        let btn1 = UIButton()
        btn1.backgroundColor=UIColor.blue
        btn1.setTitle("测试snapKit", for: .normal)
        btn1.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(btn1)
        btn1.snp.makeConstraints({(make) in
//            make.width.height.equalTo(50)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.left.equalTo(20)
            make.top.equalTo(navFullH)
//            make.center.equalTo(self.view)
        })
    }
    @objc func btnClick(){
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        guard let isLandscape:Bool=windowScene?.interfaceOrientation.isLandscape else{
          return
        };
        if isLandscape{
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
        }else{
            // 通过UIWindowScene的requestGeometryUpdate()设置
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
        }
       
        
   
    }
}
