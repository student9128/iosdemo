//
//  VideoPlayer.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/6/25.
//

import Foundation
import UIKit
import AVKit

class VideoPlayer{
    static let shared = VideoPlayer()
    
    private let playerViewController = AVPlayerViewController()
      private var player: AVPlayer?
      
      private init() {}
      
      func play(url: URL) {
          // 如果已有正在播放的视频，则先停止它
          stop()
          
          // 创建新的AVPlayer实例
          player = AVPlayer(url: url)
          
          // 将AVPlayer与AVPlayerViewController相关联
          playerViewController.player = player
          
          // 在画中画模式下保持音频播放
          playerViewController.updatesNowPlayingInfoCenter = false
          playerViewController.allowsPictureInPicturePlayback = true
          
          // 播放视频
          player?.play()
      }
      
      func stop() {
          // 停止播放器并将其重置为nil
          player?.pause()
          player = nil
          
          // 取消关联AVPlayerViewController与AVPlayer
          playerViewController.player = nil
      }
      
      func pause() {
          player?.pause()
      }
      
      func resume() {
          player?.play()
      }
      
      func setVolume(_ volume: Float) {
          player?.volume = volume
      }
      
      func getPlayerViewController() -> AVPlayerViewController {
          return playerViewController
      }
}

