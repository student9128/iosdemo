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
class TestViewController: BaseViewController,AVPlayerViewControllerDelegate {
//    var navigatonBar:UINavigationBar?
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.statusBarUIView?.backgroundColor=UIColor.systemGreen
        // Do any additional setup after loading the view.
        print("viewDidLoad==test")
//        self.view.backgroundColor=UIColor.red
        let btn = UIButton.init()
        btn.frame=CGRectMake(100,100, 100, 100)
        btn.setTitle("测试按钮", for: UIControl.State.normal)
        btn.tintColor=UIColor.yellow
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor=UIColor.blue
        btn.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
        
        let btnCopy = UIButton.init()
        btnCopy.frame=CGRectMake(220,100, 100, 50)
        btnCopy.setTitle("测试按钮Copy", for: UIControl.State.normal)
        btnCopy.tintColor=UIColor.systemPink
        btnCopy.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnCopy.backgroundColor=UIColor.systemPink
        btnCopy.addTarget(self, action: #selector(clickCopy), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btnCopy)
        let btnCopy1 = UIButton.init()
        btnCopy1.frame=CGRectMake(220,152, 100, 50)
        btnCopy1.setTitle("关闭pip", for: UIControl.State.normal)
        btnCopy1.tintColor=UIColor.systemPink
        btnCopy1.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnCopy1.backgroundColor=UIColor.purple
        btnCopy1.addTarget(self, action: #selector(closePip), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btnCopy1)
        
        let btn2=UIButton.init(type: UIButton.ButtonType.system)
        btn2.setTitle("hello", for: UIControl.State.normal)
        btn2.frame=CGRect(origin: CGPoint(x: 100, y: 210), size: CGSize(width: 100, height: 50))
        btn2.backgroundColor=UIColor.green
        btn2.addTarget(self, action: #selector(btn2Click(btn:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn2)
        let btn3 = UIButton(frame: CGRect(x: 300, y: 200, width: 50, height: 50))
        btn3.backgroundColor=UIColor.systemBlue
        btn3.addTarget(self, action: #selector(btn3Click), for: .touchUpInside)
        view.addSubview(btn3)
        let btn4 = UIButton(frame: CGRect(x: 300, y: 250, width: 50, height: 50))
        btn4.backgroundColor=UIColor.systemBlue
        btn4.addTarget(self, action: #selector(btn4Click), for: .touchUpInside)
        btn4.setTitle("btn4", for:.normal)
        view.addSubview(btn4)
//        let screenh = UIScreen.main.applicationFrame.size.height
//        let screenw = UIScreen.main.applicationFrame.size.width
//        print("screenh=\(screenh),widht=\(screenw)")
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let nativeWidth=UIScreen.main.nativeBounds.width;
        let nativeHeight=UIScreen.main.nativeBounds.height;
        let top=UIApplication.shared.keyWindow?.safeAreaInsets.top;
        let statusbarHeihgt=UIApplication.shared.statusBarFrame.size.height;
        let statusbarHeihgt2 = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0;
        let navHeight=self.navigationController?.navigationBar.bounds
        print("width=\(width),height=\(height),nW=\(nativeWidth),nH=\(nativeHeight),top=\(String(describing: top)),sH=\(statusbarHeihgt),sh2=\(statusbarHeihgt2),nav=\(navHeight)")
//        navigatonBar = UINavigationBar(frame: CGRectMake(0, 54, width, 54))
//        navigatonBar?.backgroundColor=UIColor.yellow
        
        let customTv = CustomTextView.init()
        let x=customTv.addTextView(text: "自定义TextView")
        let myView=x.view
        myView?.frame=CGRectMake(0,300, 100, 100)
        myView?.backgroundColor=UIColor.green
        self.view.addSubview(myView!)
        
        let customView = CustomView.init()
        let cView = customView.addCustomView().view
        cView?.frame=CGRect(x: 105, y: 300, width: 200, height: 100)
        cView?.backgroundColor=UIColor.systemPink
        view.addSubview(cView!)
        
    
        let url = "https://live.idbhost.com/05d2556e74e9408db0ee370b41536282/d4d54975f8a34b21bd9061ac0464a092-bafd00dba653149fda08dc8743bf8820-sd.mp4"
//        let url="https://live.idbhost.com/eadfd6c0da6a71ed80020764a3fc0102/e6fb7e66e4c949aba1429169661b8a14-6922121282a142cc4fecd0f78c7a4f8a-sd.m3u8"
        //在线视频 方式1
//        let playerItem = AVPlayerItem(url:URL(string: url)!)
//        let playerWithItem = AVPlayer(playerItem: playerItem)
//        playerWithItem.rate=1.0
//        let playerLayer = AVPlayerLayer.init(player: playerWithItem)
//        playerLayer.videoGravity=AVLayerVideoGravity.resizeAspect
//        playerLayer.frame=CGRect(x: 0, y: height/2, width: width, height: 300)
//        self.view.layer.addSublayer(playerLayer)
//        player.play()
//        let avpip = AVPictureInPictureController.init(playerLayer: playerLayer)
//        let supported=AVPictureInPictureController.isPictureInPictureSupported()
//        print("possilbe=====,supported=\(supported)")
        
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
//        vc?.player?.play()
        vc?.delegate=self
       
//        present(vc!, animated: true) {
//            vc?.player?.play()
//        }
//        NotificationCenter.default.addObserver(self, selector: #selector(playbackFinished), name: .AVPlayerItemDidPlayToEndTime, object: nil)
//        
        

        
    }
    deinit{
        vc?.player?.removeObserver(self, forKeyPath: "status")
        NotificationCenter.default.removeObserver(self)
    }
    override func setStatusBar() -> UIColor {
        return UIColor.systemGreen
    }
    override func setTitleAttrs(_ title: UILabel) {
        title.text="测试"
    }
//    override func viewWillAppear(_ animated: Bool) {
//        UIApplication.statusBarUIView?.backgroundColor=UIColor.systemGreen
//        navigationController?.navigationBar.backgroundColor=UIColor.systemGreen
//    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.statusBarUIView?.backgroundColor=UIColor.systemGreen
        self.navigationController?.navigationBar.backgroundColor=UIColor.systemGreen
        self.navigationController?.navigationBar.topItem?.title = "VC"
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
    @objc func closePip(){
        PictureInPictureManager.shared.stopPip()
    }
    @objc func clickCopy(){
        PictureInPictureManager.shared.stopPip()
        DispatchQueue.main.asyncAfter(deadline:.now()+0.3, execute: {
            print("hello")
            let v=SixViewController()
            self.navigationController?.pushViewController(v, animated: true)
        })
     
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
    @objc func btn3Click(){
        let v = ThirdViewController()
        self.navigationController?.pushViewController(v, animated: true)
    }
    @objc func btn4Click(){
        let v = FourthViewController()
        self.navigationController?.pushViewController(v, animated: true)
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

