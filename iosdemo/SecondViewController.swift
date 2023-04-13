//
//  SecondViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/9.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
class SecondViewController:UIViewController,AVPictureInPictureControllerDelegate{
    var pipController:AVPictureInPictureController!
    var pipPossibleObservation:NSKeyValueObservation?
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
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let url = "https://live.idbhost.com/05d2556e74e9408db0ee370b41536282/d4d54975f8a34b21bd9061ac0464a092-bafd00dba653149fda08dc8743bf8820-sd.mp4"
        let playerItem = AVPlayerItem(url:URL(string: url)!)
        let playerWithItem = AVPlayer(playerItem: playerItem)
        playerWithItem.rate=1.0
        let playerLayer = AVPlayerLayer.init(player: playerWithItem)
        playerLayer.videoGravity=AVLayerVideoGravity.resizeAspect
        playerLayer.frame=CGRect(x: 0, y: height/2, width: width, height: 300)
        self.view.layer.addSublayer(playerLayer)
        playerWithItem.play()
        
        let pipBtn = UIButton(frame: CGRect(x: 16, y: 100, width: 50, height: 50))
        pipBtn.setTitle("pip", for: UIControl.State.normal)
        pipBtn.addTarget(self, action: #selector(playPip), for:UIControl.Event.touchUpInside)
        view.addSubview(pipBtn)
        //        pipBtn.setImage(.pictureInPictureButtonStartImage, for:.normal)
        //        pipBtn.setImage(.pictureInPictureButtonStopImage, for: .selected)
        if AVPictureInPictureController.isPictureInPictureSupported(){
            pipController = AVPictureInPictureController(playerLayer: playerLayer)
            pipController.delegate=self
            
//            pipPossibleObservation = pipController.observe(self,options: [.initial,.new]{[weak self] _,change in pipBtn.isEnabled=change.newValue??false})
        }else{
            pipBtn.isEnabled=false
        }
        
        
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
    @objc func playPip(){
        if(pipController.isPictureInPictureActive){
            pipController.stopPictureInPicture()
        }else{
            if AVPictureInPictureController.isPictureInPictureSupported(){
                pipController.startPictureInPicture()
//                self.navigationController?.popViewController(animated: true)
            }
        }
         

      
    }
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerWillStartPictureInPicture")
    }
    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerDidStartPictureInPicture")
        self.navigationController?.popViewController(animated: true)
    }
    
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
    print("pictureInPictureControllerWillStopPictureInPicture")
    }
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
    print("pictureInPictureControllerDidStopPictureInPicture")
    }
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        print("failedToStartPictureInPictureWithError")
    }
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
     print("restoreUserInterfaceForPictureInPictureStopWithCompletionHandler")
    }
}
