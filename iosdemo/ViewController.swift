//
//  ViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/3.
//

import UIKit
import AVFoundation
import AVKit

var vc:AVPlayerViewController?
class ViewController: UIViewController,AVPlayerViewControllerDelegate {
    var navigatonBar:UINavigationBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.statusBarUIView?.backgroundColor=UIColor.systemGreen
        // Do any additional setup after loading the view.
        print("viewDidLoad==")
//        self.view.backgroundColor=UIColor.red
        let btn = UIButton.init()
        btn.frame=CGRectMake(100,100, 100, 100)
        btn.setTitle("测试按钮", for: UIControl.State.normal)
        btn.tintColor=UIColor.yellow
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor=UIColor.blue
        btn.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
        
        let btn2=UIButton.init(type: UIButton.ButtonType.system)
        btn2.setTitle("hello", for: UIControl.State.normal)
        btn2.frame=CGRect(origin: CGPoint(x: 100, y: 210), size: CGSize(width: 100, height: 50))
        btn2.backgroundColor=UIColor.green
        btn2.addTarget(self, action: #selector(btn2Click(btn:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn2)
//        let screenh = UIScreen.main.applicationFrame.size.height
//        let screenw = UIScreen.main.applicationFrame.size.width
//        print("screenh=\(screenh),widht=\(screenw)")
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let nativeWidth=UIScreen.main.nativeBounds.width;
        let nativeHeight=UIScreen.main.nativeBounds.height;
//        let top=UIApplication.shared.keyWindow?.safeAreaInsets.top;
//        let statusbarHeihgt=UIApplication.shared.statusBarFrame.size.height;
        let statusbarHeihgt2 = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0;
//        print("width=\(width),height=\(height),nW=\(nativeWidth),nH=\(nativeHeight),top=\(String(describing: top)),sH=\(statusbarHeihgt),sh2=\(statusbarHeihgt2)")
        navigatonBar = UINavigationBar(frame: CGRectMake(0, 54, width, 54))
        navigatonBar?.backgroundColor=UIColor.yellow
        
        let customTv = CustomTextView.init()
        let x=customTv.addTextView(text: "自定义TextView")
        let myView=x.view
        myView?.frame=CGRectMake(0,300, 100, 100)
        myView?.backgroundColor=UIColor.green
        self.view.addSubview(myView!)
        let avpip = AVPictureInPictureController()
        let possible=avpip.isPictureInPicturePossible
        print("possilbe=====\(possible)")
        let url = "https://live.idbhost.com/05d2556e74e9408db0ee370b41536282/d4d54975f8a34b21bd9061ac0464a092-bafd00dba653149fda08dc8743bf8820-sd.mp4"
        //在线视频 方式1
//        let playerItem = AVPlayerItem(url:URL(string: url)!)
//        let player = AVPlayer(playerItem: playerItem)
//        player.rate=1.0
//        let playerLayer = AVPlayerLayer.init(player: player)
//        playerLayer.videoGravity=AVLayerVideoGravity.resizeAspect
//        playerLayer.frame=CGRect(x: 0, y: height/2, width: width, height: 300)
//        self.view.layer.addSublayer(playerLayer)
//        player.play()
        
        //方式2
        let player = AVPlayer(url: URL(string: url)!)
//        player.addObserver(<#T##observer: NSObject##NSObject#>, forKeyPath: <#T##String#>, context: <#T##UnsafeMutableRawPointer?#>)
        vc = AVPlayerViewController()
        vc?.player = player
        vc?.view.frame=CGRect(x: 0, y: height/2, width: width, height: 300)
        vc?.player?.addObserver(self, forKeyPath: "status",options:[.new],context: nil)
        vc?.allowsPictureInPicturePlayback=true
        addChild(vc!)
        view.addSubview(vc!.view)
        vc?.player?.play()
        vc?.delegate=self
       
//        present(vc, animated: true) {
//            vc.player?.play()
//        }
        NotificationCenter.default.addObserver(self, selector: #selector(playbackFinished), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        

        
    }
    deinit{
        vc?.player?.removeObserver(self, forKeyPath: "status")
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("will Disappear")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("did Disappear")
     
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("hello====\(String(describing: keyPath))")
    }
    @objc func playbackFinished(){
        print("Player ends playing video")
    }
    @objc func click(){
        print("hello")
        let v=SecondViewController()
        self.navigationController?.pushViewController(v, animated: true)
    }
    @objc func btn2Click(btn:UIButton){
        print("btn2click \(btn)")
        Toast.toast(at:self.view, message: "toast")
        
    }
    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("pip---willStart")
    }
    func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("pip---didStart")
    }
    func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("pip---willStop")
    }
    func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("pip---didStop")
    }
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool {
        print("是否在开始画中画时自动将当前的播放界面dismiss掉 返回true则自动dismiss 返回false则不会自动dismiss")
        return true
    }
    func playerViewControllerRestoreUserInterfaceForPictureInPictureStop(_ playerViewController: AVPlayerViewController) async -> Bool {
        print("返回用户界面是否关闭画中画")
        return true
    }
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForFullScreenExitWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        print("用户点击还原按钮 从画中画模式还原回app内嵌模式时调用的方法")
    }
    


}
