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
        // Set the background color of the tab bar
//        tabBar.barTintColor = .red
//        tabBar.backgroundColor = .yellow.withAlphaComponent(0.0)
               
               // Make the tab bar translucent
//               tabBar.isTranslucent = true
//        tabBar.backgroundImage=UIImage()
        var bottomPadding:CGFloat=0
        var topPadding=0.0
        if let window = UIApplication.shared.windows.first {
            let safeArea = window.safeAreaInsets
            bottomPadding = safeArea.bottom
            topPadding=safeArea.top
            
            print("The height of the bottom navigation bar is \(bottomPadding) pixels.,top=\(topPadding)")
        }
        let blurEffect = UIBlurEffect(style: .regular)

        // Create a UIVisualEffectView object with the UIBlurEffect object
        let blurView = UIVisualEffectView(effect: blurEffect)

        // Set the frame of the blur view to the bounds of the tab bar controller
        print("tabbar.bound=\(tabBar.bounds)")
//        view.frame=tabBar.bounds
        blurView.frame=CGRect(x: 0, y: screenHeight-tabBar.bounds.height-bottomPadding, width: screenWidth, height: tabBar.bounds.height+bottomPadding)
        let count = view.subviews.count
//        tabBar.backgroundColor=UIColor.red
//        tabBar.isTranslucent=true
        print("count=\(count)")
        view.insertSubview(blurView, at: 1)
        initTab()
//        self.view.backgroundColor=UIColor.green
//        UITabBar.appearance().backgroundColor=UIColor.clear
        
        
    }
    private func initTab(){
        let home = Home()
        home.title="HomeX"
        let test = Test()
        let vc = TestViewController()
        let fif=FifthViewController()
//        let homeImage: UIImage? = UIImage(named: "home")
        
//        homeImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        let homeTab: UITabBarItem = UITabBarItem(title: "Home", image:setNewImage(image:UIImage(named: "home")!)!,selectedImage: setNewImage(image:UIImage(named: "home_fill")!)!)
        home.tabBarItem = homeTab
//        home.tabBarItem.imageInsets=UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        let originImage = UIImage(named: "test")
        let originTestFillImage = UIImage(named: "test_fill")
//        let newSize=CGSize(width: 24, height: 24)
//        let render = UIGraphicsImageRenderer(size: newSize)
//        let newImage = render.image { UIGraphicsImageRendererContext in
//            originImage?.draw(in: CGRect(origin: .zero, size: newSize))
//        }
        test.tabBarItem = UITabBarItem(title: "Test", image:setNewImage(image: originImage!)!,selectedImage: setNewImage(image: originTestFillImage!)!)
//        test.tabBarItem.imageInsets=UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
//        test.tabBarItem.titlePositionAdjustment=UIOffset(horizontal: 0, vertical: 0)
//        vc.tabBarItem = UITabBarItem(title: "VC", image:UIImage(named: "cart"),selectedImage: UIImage(named: "cart_fill"))
//        vc.tabBarItem.imageInsets=UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
//        let image:UIImage=UIImage.myImage(name: "cart")
        vc.tabBarItem=UITabBarItem(title: "VC", image:setNewImage(image:UIImage(named: "cart")!), selectedImage: setNewImage(image:UIImage(named: "cart_fill")!))
        viewControllers=[home,test,vc]
     

        let h=tabBar.frame.size.height
            print("height=\(h)")
        
        
        
        if let tabBarHeight = self.tabBarController?.tabBar.frame.size.height {
            print("Tab bar height: \(tabBarHeight)")
        }
        
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
    func setNewImage(image:UIImage)->UIImage?{
      return image.reSizeImage(reSize: CGSize(width: 24, height: 24))
    }
}
