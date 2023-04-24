//
//  Home.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/17.
//

import Foundation
import UIKit
import SnapKit
class Home :UIViewController{
    var segment:UISegmentedControl?
    var contentView:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let item=["UIKit","SwiftUI"]
        segment = UISegmentedControl.init(items: item)
        segment?.frame=CGRect(x: (screenWidth-200)/2, y: 100, width: 200, height: 40)
//        segment?.tintColor = UIColor.systemTeal
        segment?.selectedSegmentTintColor=UIColor.systemTeal
//        segment?.backgroundColor=UIColor.green
        segment?.selectedSegmentIndex=0
        segment?.addTarget(self, action: #selector(clickSegment(seg:)), for: UIControl.Event.valueChanged)
        
        view.addSubview(segment!)
        
        contentView=UIView()
        view.addSubview(contentView!)
        contentView?.snp.makeConstraints({(make)in
            make.width.equalTo(screenWidth)
            make.top.equalTo(140)
            make.bottom.equalTo(self.view).offset(-100)
        })
        
        contentView?.inputViewController?.addChild(onView)
        contentView?.addSubview(onView.view)
        onView.view.snp.makeConstraints({make in
            make.width.equalTo(screenWidth)
            make.top.equalTo(self.contentView!)
            make.bottom.equalTo(self.contentView!)
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        print("home快出现了")
        self.navigationController?.navigationBar.backgroundColor=UIColor.systemTeal
        UIApplication.statusBarUIView?.backgroundColor=UIColor.systemTeal
    }
    override func viewDidAppear(_ animated: Bool) {
//        print("home加载了")
        
    }
   @objc func clickSegment(seg:UISegmentedControl){
        switch seg.selectedSegmentIndex{
        case 0:
            if(contentView!.subviews.contains(onView.view)){
                contentView!.bringSubviewToFront(onView.view)
            }else{
                
                contentView?.inputViewController?.addChild(onView)
                contentView?.addSubview(onView.view)
            }
            
//            replaceController(oldController: secView, newController: onView)
            break
        case 1:
            if(contentView!.subviews.contains(secView.view)){
                contentView!.bringSubviewToFront(secView.view)
            }else{
                contentView?.inputViewController?.addChild(secView)
                contentView?.addSubview(secView.view)
                secView.view.snp.makeConstraints({make in
                    make.width.equalTo(screenWidth)
                    make.top.equalTo(self.contentView!)
                    make.bottom.equalTo(self.contentView!)
                })
            }
//            replaceController(oldController: onView, newController: secView)
            break
        default: break
            
        }
    }
    lazy var onView:UIKitListViewController={
        let temp=UIKitListViewController()
        return temp
    }()
    lazy var secView:SwiftUIListViewController={
        let temp=SwiftUIListViewController()
        return temp
    }()
    var currentController:UIViewController?
    func replaceController(oldController:UIViewController,newController:UIViewController){
        print("走吗12")
        if(self.currentController!==nil&&self.currentController! .isEqual(newController)){
            return
        }
        print("走吗")
        self.contentView?.inputViewController?.addChild(newController)
//        self.contentView?.inputViewController?.tran
        self.contentView?.inputViewController?.transition(from: oldController, to: newController, duration: 0, animations: nil) { finished in
            if(finished){
                self.contentView?.addSubview(newController.view)
                self.currentController = newController
            }else{
                self.currentController=oldController
            }
        }
        
    }
}
