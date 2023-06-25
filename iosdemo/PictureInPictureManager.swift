
//
//  PictureInPictureManager.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/6/25.
//

import Foundation
import AVKit
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
    private var pictureInPictureController: AVPictureInPictureController?
    func initPiPManager(playerLayer:AVPlayerLayer){
        if(pictureInPictureController != nil){
            pictureInPictureController?.stopPictureInPicture()
        }
//        if pictureInPictureController==nil{
            print("走了pictureInPictureController==nil")
            pictureInPictureController = AVPictureInPictureController(playerLayer:playerLayer)
            pictureInPictureController?.delegate=self
//        }
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
    }
    
    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerDidStartPictureInPicture==")
        // Handle the event when the PiP mode has started.
    }
    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        print("pictureInPictureController=error=\(error)")
        
        // Handle the event when the PiP mode fails to start.
    }
    
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerWillStopPictureInPicture==")
        // Handle the event when the PiP mode is about to stop.
    
    }
    
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("pictureInPictureControllerDidStopPictureInPicture==")
        // Handle the event when the PiP mode has stopped.
    }
    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        print("restoreUserInterfaceForPictureInPictureStopWithCompletionHandler==")
        // Restore the user interface after PiP mode has stopped.
        completionHandler(true)
    }
    
}
