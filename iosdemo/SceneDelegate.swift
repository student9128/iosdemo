//
//  SceneDelegate.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/3.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        print("scene==willConnectTo=========")
        guard let _ = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene as! UIWindowScene)
//        let viewController = ViewController()
        let tabController = TabViewController()
        let nav=UINavigationController.init(rootViewController: tabController)
//        nav.navigationBar.backgroundColor=UIColor.systemTeal
//        nav.navigationBar.standardAppearance.backgroundColor=UIColor.purple
        UIApplication.statusBarUIView?.backgroundColor=UIColor.systemGreen
        UIApplication.shared.statusBarStyle=UIStatusBarStyle.lightContent
        
//        nav.setToolbarHidden(false, animated: true)
//        let b2=UIBarButtonItem.init(systemItem:UIBarButtonItem.SystemItem.add)
//        nav.setToolbarItems([b2], animated: true)
//        nav.navigationBar.barStyle=UIBarStyle.black
//        nav.navigationBar.barTintColor=UIColor.systemYellow
//        window.rootViewController=viewController
        self.window?.rootViewController=nav
        let bgColor=UIColor(red: 0xf6/255.0, green: 0xf1/255.0, blue: 0xe9/255.0, alpha: 1.0)
        self.window?.backgroundColor=bgColor
//        window.backgroundColor=UIColor.white
//        self.window=window;
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("sceneDidDisconnect")
    }
    

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive可见=\(scene)")
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive不可见")
        
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("sceneWillEnterForeground=\(scene)")
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        PictureInPictureManager.shared.startPip()
        print("sceneDidEnterBackground")
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

