//
//  SevenViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/6/27.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import MediaPlayer
class SevenViewController:BaseViewController,AVPictureInPictureControllerDelegate{
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer!
    private var pictureInPictureController: AVPictureInPictureController?
    private var progressUpdateTimer: Timer?
    var nowPlayingInfo = [String : Any]()
    var urlString   : String?
    var imageUrl    : String?
    var autioTitle       : String?
    var artist      : String?
    var albumTitle  : String?
    var duration    : Int = 0
    var isPlaying   : Bool = false {
        didSet {
            if let c = _isPlayingChanged{
                c(isPlaying)
            }
        }
    }
    var isReady     : Bool = false
    var progress    : Int = 0 {
        didSet {
            if let c = _progressChanged{
                c(progress)
            }
        }
    }
    private var _isPlayingChanged : ((Bool)->Void)?
    func onIsPlayingChanged(_ isPlayingChanged : @escaping ((Bool)->Void)){
        _isPlayingChanged = isPlayingChanged
    }
    
    private var _progressChanged : ((Int)->Void)?
    func onProgressChanged(_ progressChanged : @escaping ((Int)->Void)){
        _progressChanged = progressChanged
    }
    private var customView:UIView!
    override func viewDidLoad() {
        customView = UIView()
        customView.backgroundColor=UIColor.blue
        var textView = UITextView()
        textView.text="Hello"
        textView.backgroundColor=UIColor.red
        customView.addSubview(textView)
        textView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
        let url = "https://live.idbhost.com/05d2556e74e9408db0ee370b41536282/d4d54975f8a34b21bd9061ac0464a092-bafd00dba653149fda08dc8743bf8820-sd.mp4"
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let playerItem = AVPlayerItem(url:URL(string: url)!)
        let videoURL = URL(string: url)!
        self.player = AVPlayer(url: videoURL)
        self.playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame=CGRect(x: 0, y: 0, width: width, height: 350)
        self.view.layer.addSublayer(self.playerLayer)
        self.player?.play()
        isPlaying=true
        let btn=UIButton(type: .system)
        btn.frame=CGRect(x: 0, y: 350, width: 100, height: 50)
        btn.setTitle("开启画中画", for: .normal)
        btn.backgroundColor=UIColor.green
        btn.addTarget(self, action: #selector(startPip), for: .touchUpInside)
        let btn2=UIButton(type: .system)
        btn2.frame=CGRect(x: 110, y: 350, width: 100, height: 50)
        btn2.backgroundColor=UIColor.yellow
        btn2.setTitle("关闭画中画", for: .normal)
        btn2.addTarget(self, action: #selector(closePip), for: .touchUpInside)
        self.view.addSubview(btn)
        self.view.addSubview(btn2)
        pictureInPictureController=AVPictureInPictureController(playerLayer: playerLayer)
        pictureInPictureController?.delegate=self
        imageUrl="https://t7.baidu.com/it/u=1819248061,230866778&fm=193&f=GIF"
        autioTitle="Hello"
        artist="artist"
        albumTitle="albumTitle"
        duration=120000
        
        
    }
    @objc func startPip(){
        if AVPictureInPictureController.isPictureInPictureSupported(){
            pictureInPictureController?.startPictureInPicture()
        }
    }
    @objc func closePip(){
        pictureInPictureController?.stopPictureInPicture()
    }
   
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        logE("好吧")
        logD("pictureInPictureControllerWillStartPictureInPicture==")
        // 打印所有window
        print("画中画初始化后：\(UIApplication.shared.windows)")
        // 注意是 first window
        if let window = UIApplication.shared.windows.first {
            // 把自定义view加到画中画上
            window.addSubview(customView)
            // 使用自动布局
            customView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(100)
//                make.edges.equalTo(sel).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
                
            }
        }
    }
    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        logI("pictureInPictureControllerDidStartPictureInPicture")
        initRemoteCommand()
        initNowingPlayCenter()
    }
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        logD("pictureInPictureControllerWillStopPictureInPicture==")
    }
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        logI("pictureInPictureControllerDidStopPictureInPicture")
    }
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        logE("failedToStartPictureInPictureWithError=\(error)")
    }
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        logI("restoreUserInterfaceForPictureInPictureStopWithCompletionHandler")
        completionHandler(true)
    }
    func initRemoteCommand(){
        let commondCenter: MPRemoteCommandCenter = MPRemoteCommandCenter.shared()
        commondCenter.playCommand.isEnabled=true
        commondCenter.pauseCommand.isEnabled=true
        commondCenter.skipForwardCommand.isEnabled=true
        commondCenter.skipBackwardCommand.isEnabled=true
        commondCenter.skipForwardCommand.preferredIntervals=[15]
        commondCenter.skipBackwardCommand.preferredIntervals=[15]
        commondCenter.skipBackwardCommand.addTarget{ [unowned self]event in
            if isPlaying {
                let progress = CMTimeGetSeconds(player!.currentTime())
                player?.seek(to: CMTimeMake(value: Int64(progress - 15.0), timescale: 1))
                updateNowPlayingInfoProgress(Float(progress))
            }
            return .success
        }
        commondCenter.skipForwardCommand.addTarget{[unowned self] event in
            if isPlaying {
                let progress = CMTimeGetSeconds(player!.currentTime())
                player?.seek(to: CMTimeMake(value: Int64(progress + 15.0), timescale: 1)){finish in}
                updateNowPlayingInfoProgress(Float(progress))
            }
            return .commandFailed
        }
        commondCenter.playCommand.addTarget{[unowned self]event in
            playPause()
            return .success
//            if player?.rate == 0.0 {
//                playPause()
//                return .success
//            }else{
//                print("播放失败")
//            }
//            return .commandFailed
        }
        commondCenter.pauseCommand.addTarget{ [unowned self]event in
            playPause()
            return .success
//            if player?.rate == 1.0 {
//                playPause()
//                return .success
//            }else{
//                print("暂停失败")
//            }
//            return .commandFailed
        }
    }
    func initNowingPlayCenter(){
        
        if let url = URL(string: imageUrl ?? "") {
            downloadImage(url:url) { image in
                self.nowPlayingInfo[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { size in
                    return image
                }
                MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingInfo
            }
        }
        
        let totalDuration = Float (duration / 1000)
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = albumTitle
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = totalDuration
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func updateNowPlayingInfoProgress(_ progress: Float) {
        print("progress==\(progress)")
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = progress
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func playPause() {
        if(isPlaying){
            player?.pause()
            isPlaying=false
        }else{
            player?.play()
            isPlaying=true
        }
//        if let p = player {
//            if isPlaying {
//                p.pause()
//                isPlaying = false
//            }else {
//                p.play()
//                isPlaying = true
//            }
//        }else{
//            isPlaying = false
//        }
        let progress = CMTimeGetSeconds(player!.currentTime())
        updateNowPlayingInfoProgress(Float(progress))
        createTimers(true)
    }
    func createTimers(_ create: Bool) {
        if create {
            createTimers(false)
            progressUpdateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateProgress(_:)), userInfo: nil, repeats: true)
        } else {
            if let put = progressUpdateTimer {
                put.invalidate()
                progressUpdateTimer = nil
            }
        }
    }
    @objc func updateProgress(_ updatedTimer: Timer?) {
        if isPlaying {
            progress = Int(CMTimeGetSeconds(player!.currentTime())) *  1000
        }
    }
    
    func downloadImage(url: URL, callback: @escaping  (UIImage)->() ) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() { () -> Void in
                callback(UIImage(data: data) ?? UIImage())
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}
