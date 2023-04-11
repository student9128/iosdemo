//
//  CutomTextView.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/10.
//

import Foundation
import SwiftUI
@objc class CustomTextView:NSObject{
    @objc func addTextView(text:String)->UIViewController{
        return UIHostingController(rootView: MyTextView(text: text))
    }
}
struct MyTextView:View{
    var text:String=""
    var body: some View{
        Text(text)
    }
}
