
//
//  PictureInPictureManager.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/6/25.
//

import Foundation
import AVKit
import MediaPlayer
class PictureInPictureManager:NSObject{
    static let shared = PictureInPictureManager()
    var isPipSupported:Bool{
        return AVPictureInPictureController.isPictureInPictureSupported()
    }
    var canStartPipAuto:Bool{
        guard pictureInPictureController != nil else{
            print("false====")
            return false}
        print("false====这里")
        return pictureInPictureController!.canStartPictureInPictureAutomaticallyFromInline
    }
    var nowPlayingInfo = [String: Any]()
    private var pictureInPictureController: AVPictureInPictureController?
    private var duration:CMTime=CMTime(seconds: 0, preferredTimescale: 1)
    private var avPlayer:AVPlayer?
    private var imageCover : UIImage?
    var timeObserve:Any?
    var playerDuration : CMTime {
        get {
            if let thePlayerItem = avPlayer?.currentItem {
                if thePlayerItem.status == .readyToPlay {
                    return thePlayerItem.duration
                }else {
                    return CMTimeMake(value: Int64(60000/1000), timescale: 1)
                }
            }
            return CMTime.invalid
        }
    }
    func initPiPManager(playerLayer:AVPlayerLayer){
        if(pictureInPictureController != nil){
            pictureInPictureController?.stopPictureInPicture()
        }
//        if pictureInPictureController==nil{
            print("走了pictureInPictureController==nil")
            pictureInPictureController = AVPictureInPictureController(playerLayer:playerLayer)
            pictureInPictureController?.delegate=self
        duration=playerLayer.player?.currentItem?.duration ?? CMTime(seconds: 0, preferredTimescale: 1)
        avPlayer = playerLayer.player
//               let title = mediaItem.stringValue {
//                nowPlayingInfo[MPMediaItemPropertyTitle] = title
//            }
//        }
        let interval = CMTime(seconds: 1, preferredTimescale: 1)
        timeObserve = avPlayer?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main){
            time in
            let currentTime = CMTimeGetSeconds(time)
            print("currentTime==\(currentTime)")
            if((self.pictureInPictureController?.isPictureInPictureActive) != nil){
                self.updateNow()
            }
        }
        // 监听缓存状态
        avPlayer?.currentItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        avPlayer?.currentItem?.addObserver(self, forKeyPath: "status", context:nil)
        guard let url = URL(string: "https://t7.baidu.com/it/u=1819248061,230866778&fm=193&f=GIF") else { return }
        let dataTask = URLSession.shared.dataTask(with: url){(data, response, error)in
            if let error = error{
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            guard let data=data,let image=UIImage(data: data)else{
                print("Invalid image data")
                return
            }
            self.imageCover=image
                 
        }
        dataTask.resume()
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("keyPath===\(keyPath)")
    }
    func startPip(){
        guard isPipSupported else {
            print("走了else")
            return}
        print("pictureInPictureController是否为nil=\(pictureInPictureController==nil)")
        print("\(pictureInPictureController?.isPictureInPictureActive),\(pictureInPictureController?.isPictureInPictureSuspended),\(String(describing: pictureInPictureController?.isPictureInPicturePossible))")
        pictureInPictureController?.stopPictureInPicture()
        pictureInPictureController?.startPictureInPicture()
    }
    func stopPip(){
        pictureInPictureController?.stopPictureInPicture()
    }
    func destoryX(){
        pictureInPictureController=nil
    }
    
}
extension PictureInPictureManager: AVPictureInPictureControllerDelegate {
    
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerWillStartPictureInPicture==")
        // Handle the event when the PiP mode is about to start.
        enableRemoteCommand()
    }
    
    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerDidStartPictureInPicture==")
        // Handle the event when the PiP mode has started.
//        avPlayer?.seek(to: CMTime(seconds: 80, preferredTimescale: 1), toleranceBefore: CMTime(seconds: 0, preferredTimescale: 1), toleranceAfter: CMTime(seconds: 180, preferredTimescale: 1))
    
    }
    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        print("pictureInPictureController=error=\(error)")
        
        // Handle the event when the PiP mode fails to start.
    }
    
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerWillStopPictureInPicture==")
        // Handle the event when the PiP mode is about to stop.
        avPlayer?.currentItem?.removeObserver(self, forKeyPath:"loadedTimeRanges")
        avPlayer?.currentItem?.removeObserver(self, forKeyPath:"status")
        avPlayer?.removeTimeObserver(timeObserve!)
    
    }
    
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerDidStopPictureInPicture==")
        // Handle the event when the PiP mode has stopped.
        disableRemoteCommand()
    }
    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        print("restoreUserInterfaceForPictureInPictureStopWithCompletionHandler==")
        // Restore the user interface after PiP mode has stopped.
        completionHandler(true)
    }
    func enableRemoteCommand(){
        MPRemoteCommandCenter.shared().playCommand.isEnabled=true
        MPRemoteCommandCenter.shared().pauseCommand.isEnabled=true
        MPRemoteCommandCenter.shared().skipForwardCommand.isEnabled=true
        MPRemoteCommandCenter.shared().skipBackwardCommand.isEnabled=true
        MPRemoteCommandCenter.shared().skipForwardCommand.preferredIntervals=[15]
        MPRemoteCommandCenter.shared().skipBackwardCommand.preferredIntervals=[15]
        MPRemoteCommandCenter.shared().skipBackwardCommand.addTarget{[unowned self] event in
            let currentTime = self.avPlayer?.currentItem?.currentTime()
            let duration = self.avPlayer?.currentItem?.duration
            let targetTime = max(CMTimeGetSeconds(currentTime!)-15, 0)
            let ha=Int64(CMTimeGetSeconds(currentTime!)-15)
            self.avPlayer?.seek(to: CMTimeMake(value: ha, timescale: 1))
            print("后台haha==\(ha)")
            self.updateNow()
//            self.avPlayer?.seek(to: CMTime(seconds: targetTime, preferredTimescale: 1)){b in
//                            self.updateNow()
//            }

            return .success
        }
        MPRemoteCommandCenter.shared().skipForwardCommand.addTarget{[unowned self] event in
            let currentTime = self.avPlayer?.currentItem?.currentTime()
            let duration = self.avPlayer?.currentItem?.duration
            print("currentTime====!!!!===\(CMTimeGetSeconds(currentTime!))")
            let targetTime = min(CMTimeGetSeconds(currentTime!)+15, CMTimeGetSeconds(duration!))
//            self.avPlayer?.seek(to: CMTime(seconds: targetTime, preferredTimescale: 1)){b in
//                self.updateNow()
//            }
            if(self.avPlayer?.rate==1.0){
                let ha=Int64(CMTimeGetSeconds(currentTime!)+15)
                self.avPlayer?.seek(to: CMTimeMake(value: ha, timescale: 1))
                print("快进haha==\(ha)")
                self.updateNow()
                
                return .success
            }
            return .commandFailed
        }
        MPRemoteCommandCenter.shared().playCommand.addTarget{[unowned self]event in
            avPlayer?.play()
                self.updateNow()
            return .success
//            if(avPlayer?.rate==0.0){
//                avPlayer?.play()
////                self.updateNow()
//                return .success
//            }
//
//
//            return .commandFailed
        }
        MPRemoteCommandCenter.shared().pauseCommand.addTarget{[unowned self]event in
            avPlayer?.pause()
            self.updateNow()
            return .success
//            if avPlayer?.rate==1.0{
//                avPlayer?.pause()
////                self.updateNow()
//                return .success
//            }
//            
//            return .commandFailed
        }
    
//        guard let image = UIImage(named: "home") else { return }
//        var w = MPMediaItemArtwork(boundsSize: CGSizeMake(50, 50)){_ -> UIImage in return image}
//        var info = [MPMediaItemPropertyAlbumTitle:"Hello测试",MPMediaItemPropertyTitle:"MPMediaItemPropertyTitle",MPMediaItemPropertyArtwork:w,MPMediaItemPropertyPlaybackDuration:CMTimeGetSeconds(duration)] as [String : Any]
        // 创建媒体信息字典
//        var nowPlayingInfo = [String: Any]()
//
//        nowPlayingInfo[MPMediaItemPropertyTitle] = "歌曲标题"
//        nowPlayingInfo[MPMediaItemPropertyArtist] = "歌曲艺术家"
//        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "专辑标题"
//        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 300 // 音频总长度（单位：秒）
//        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 100 // 当前播放进度（单位：秒）
//        MPNowPlayingInfoCenter.default().nowPlayingInfo=info
        
        if let mediaItem = avPlayer?.currentItem?.asset.commonMetadata.first(where: { $0.commonKey == .commonKeyTitle }),
           let title = mediaItem.stringValue {
            nowPlayingInfo[MPMediaItemPropertyTitle] = title
        }
        nowPlayingInfo[MPMediaItemPropertyTitle] = "歌曲标题"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "My Artist Name"
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "My Album Title"
        
        if let image = imageCover{
            let artwork = MPMediaItemArtwork(boundsSize: image.size) { (_) -> UIImage in
              return image
            }
            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        }
      updateNow()
    }
    func disableRemoteCommand(){
        MPRemoteCommandCenter.shared().playCommand.isEnabled=false
        MPRemoteCommandCenter.shared().pauseCommand.isEnabled=false
        MPRemoteCommandCenter.shared().skipForwardCommand.isEnabled=false
        MPRemoteCommandCenter.shared().skipBackwardCommand.isEnabled=false
    }
    
    func updateNow(){
        // 设置锁屏界面和播放中心的媒体信息

   
        nowPlayingInfo[MPNowPlayingInfoPropertyMediaType]=NSNumber(value: MPNowPlayingInfoMediaType.audio.rawValue)
     
    
//        var image = UIImage(data: nsData! as Data)
//        if let image = UIImage(named: "home_fill") {
//          // 将UIImage转换成MPMediaItemArtwork
//          let artwork = MPMediaItemArtwork(boundsSize: image.size) { (_) -> UIImage in
//            return image
//          }
//          nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
//        }
    
      
        
        if let rate = avPlayer?.rate{
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = NSNumber(value:rate)
        }
        
        
        if let duration = avPlayer?.currentItem?.duration.seconds,
           let currentTime = avPlayer?.currentTime().seconds {
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = NSNumber(value: duration)
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = NSNumber(value: currentTime)
        }
        print("playingInfo=\(nowPlayingInfo)")
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
}
