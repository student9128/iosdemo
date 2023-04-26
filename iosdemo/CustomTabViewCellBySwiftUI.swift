//
//  CustomTabViewCellBySwiftUI.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/23.
//

import Foundation
import SwiftUI
@objc class CustomTabViewCellBySwiftUI:NSObject{
    func customTabViewCell(tabCellModel:TabCellModel)->UIViewController{
        return UIHostingController(rootView: ListViewItem(tabCellModel:tabCellModel))
    }
}

struct ListViewItem:View{
//    @AppStorage("key") var test=""//这里和UserDefaults对应通过该方法传值
    @ObservedObject var tabCellModel:TabCellModel
    var body: some View{
        //        GeometryReader{_ in
        HStack(){
            //写法一
            Color.purple.overlay{

                Text("\(tabCellModel.avatar)")
                    .foregroundColor(.white)
                    .padding(.zero)
               
            }.frame(width: 50,height: 50)
            .clipShape(Circle())
            let color:Color = tabCellModel.color
            color.overlay{
                Text("\(tabCellModel.avatar)")
                    .foregroundColor(.white)
                    .padding(.zero)
            }.frame(width: 50,height: 50)
                .clipShape(Circle())
            //测试加圆形背景的写法
//            Text("13哈哈哈哈哈")
//              .padding()
//              .background(.white)
//              .fixedSize()
//              .frame(width: 20)
//              .border(Color.blue)
//              .clipShape(Circle())
//            Text("13")
//              .padding()
//              .overlay(
//                Circle()
//                    .stroke(.white, lineWidth: 4)
//                  .padding(6)
//              )
            //写法二
            //            Group{
//                            Text("\(tabCellModel.avatar)")
//                                .foregroundColor(.white)
//                                .padding(.zero)
            //            }.background(Color.purple).frame(width: 40,height: 40)
            //写法三
            //            ZStack {
            //              Circle()
            //                    .stroke(Color.purple, lineWidth: 4)
            //
            //              Text("13")
            //            }
            //            .frame(width: 40, height: 40)
            Text("\(tabCellModel.content)")
                .fontWeight(.bold)
                .frame(alignment: .leading)
            Spacer()
        }
        //        }
    }
}
//struct ListViewItemPrivew:PreviewProvider{
//    static var previews: some View{
//        ListViewItem(avatar: "头像",content: "内容")
//    }
//}
