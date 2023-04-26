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
        Text(text).onTapGesture {
            print("hello生效了吗")
        }
    }
}
@objc class CustomView:NSObject{
    @objc func addCustomView()->UIViewController{
        return UIHostingController(rootView: MyCustomView())
    }
}
struct MyCustomView:View{
    var body: some View{
        HStack(alignment:VerticalAlignment.center){
            Image("home")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.blue)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .clipShape(Circle())
                .overlay(Circle().stroke(.green, lineWidth: 1))
            VStack(alignment:.leading){
                Text("Hello").foregroundColor(.green).fontWeight(.bold).font(.system(size: 14))
                Text("Hello").foregroundColor(.blue).fontWeight(.thin).font(.system(size: 12))
            }.foregroundColor(Color.blue)
            Image("home")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
            AsyncImage(url: URL(string: "https://img1.doubanio.com/view/photo/l/public/p2292035027.jpg")) { image in
                image.resizable() // 填充
            } placeholder: {
                Color.blue // 占位背景色
            }
            .frame(width: 30, height: 30) // 大小
            .clipShape(RoundedRectangle(cornerRadius: 15)) // 圆角



        }.padding()
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyCustomView()
//    }
//}
