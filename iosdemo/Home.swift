//
//  Home.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/17.
//

import Foundation
import UIKit
import SnapKit
class Home :BaseViewController{
    var segment:UISegmentedControl?
    var contentView:UIView?
    var navigationBarHeight=0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let item=["UIKit","SwiftUI"]
        let h = self.tabBarController?.tabBar.frame.size.height
        print("home h=\(String(describing: h))")
        let y=self.tabBarController?.tabBar.frame.origin.y
        let x=self.tabBarController?.tabBar.frame.origin.x
        print("home y=\(String(describing: y)),x=\(String(describing: x)),screenHeight=\(screenHeight),native=\(nativeScreenHeight)")
        var bottomPadding:CGFloat=0
        var topPadding=0.0
        if let window = UIApplication.shared.windows.first {
            let safeArea = window.safeAreaInsets
            bottomPadding = safeArea.bottom
            topPadding=safeArea.top
            
            print("The height of the bottom navigation bar is \(bottomPadding) pixels.,top=\(topPadding)")
        }
        print("nav===\(navigationBarHeight)")
        segment = UISegmentedControl.init(items: item)
        segment?.frame=CGRect(x: (screenWidth-200)/2, y: topPadding+navigationBarHeight, width: 200, height: 40)
//        segment?.tintColor = UIColor.systemTeal
        segment?.selectedSegmentTintColor=UIColor.systemTeal
        segment?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        segment?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.systemTeal], for: .normal)
//        segment?.backgroundColor=UIColor.green
        segment?.selectedSegmentIndex=0
        segment?.addTarget(self, action: #selector(clickSegment(seg:)), for: UIControl.Event.valueChanged)
        
        view.addSubview(segment!)
        segment?.snp.makeConstraints({make in
            make.topMargin.equalTo(20)
            make.centerX.equalTo(self.view.center)
        })
        
        contentView=UIView()
        view.addSubview(contentView!)
        contentView?.snp.makeConstraints({(make)in
            make.width.equalTo(screenWidth)
            make.top.equalTo(segment!).offset(40)
//            make.bottom.equalTo(self.view).offset(-49-bottomPadding)
            make.bottom.equalTo(self.view)
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
        super.viewWillAppear(animated)
        let navbar=self.navigationController?.navigationBar
        navbar?.topItem?.title = "Home"
        navbar?.topItem?.backButtonTitle="返回"
        navbar?.tintColor = .white
        navbar?.titleTextAttributes=[NSAttributedString.Key.foregroundColor:UIColor.white]
        let h=self.navigationController?.navigationBar.bounds.height
        navigationBarHeight=h ?? 0.0
        print("home快出现了 h=\(h)")
//        self.navigationController?.navigationBar.backgroundColor=UIColor.systemTeal
//        UIApplication.statusBarUIView?.backgroundColor=UIColor.systemTeal
//        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
//        titleLabel.text = "Top Title"
//        titleLabel.textColor=UIColor.white
//        titleLabel.textAlignment = .center
//
//        // Add the label as a subview of the navigation bar
//        self.navigationController?.navigationBar.addSubview(titleLabel)
        
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
