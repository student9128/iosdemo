//
//  Utils.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/9.
//

import Foundation
import UIKit
extension UIApplication {
static var statusBarUIView: UIView? {

    if #available(iOS 13.0, *) {
        let tag = 3848245

        let keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first

        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
            let statusBarView = UIView(frame: height)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = 999999

            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }

    } else {

        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
    }
    return nil
  }
}
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let nativeScreenWidth=UIScreen.main.nativeBounds.width;
let nativeScreenHeight=UIScreen.main.nativeBounds.height;

func logV(_ message:String){
    print("✈️\(message)\n")
}
func logE(_ message:String){
    print("🈲\(message)\n")
}
func logI(_ message:String){
    print("🌿\(message)\n")
}
func logW(_ message:String){
    print("⚠️\(message)\n")
}
func logD(_ message:String){
    print("🔵\(message)\n")
}
func logPurple(_ message:String){
    print("🟣\(message)\n")
}
func logCyan(_ message:String){
    print("🗳️\(message)\n")
}
