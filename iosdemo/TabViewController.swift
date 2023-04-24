//
//  TabViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/17.
//

import Foundation
import UIKit
class TabViewController :UITabBarController,UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        initTab()
//        self.view.backgroundColor=UIColor.green
        UITabBar.appearance().backgroundColor=UIColor.yellow
        
        
    }
    private func initTab(){
        let home = Home()
        let test = Test()
        let vc = TestViewController()
        let homeImage: UIImage? = UIImage(named: "home")
        
//        homeImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        let homeTab: UITabBarItem = UITabBarItem(title: "Home", image:homeImage,selectedImage: UIImage(named: "home_fill"))
        home.tabBarItem = homeTab
        home.tabBarItem.imageInsets=UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        test.tabBarItem = UITabBarItem(title: "Test", image:UIImage(named: "test"),selectedImage: UIImage(named: "test_fill"))
        test.tabBarItem.imageInsets=UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        vc.tabBarItem = UITabBarItem(title: "VC", image:UIImage(named: "cart"),selectedImage: UIImage(named: "cart_fill"))
        vc.tabBarItem.imageInsets=UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        viewControllers=[home,test,vc]
        
        
    }
    private func initImage(){
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let title=item.title
        print("title=\(title)")
        if(title=="Home"){
            UIApplication.statusBarUIView?.backgroundColor=UIColor.systemCyan
        }
    }
}
