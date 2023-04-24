//
//  CustomTabBar.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/14.
//

import Foundation
import UIKit
import SnapKit
class CustomTabBar :UIView{
    func createBackground(){
        
    }
    func createTabItem(tabArray:NSArray,imageArray:NSArray,selectArray:NSArray,titleArray:NSArray,currentIndex:Int,currentTarget:AnyObject,selector:Selector){
        let itemWidth = bounds.size.width/CGFloat(Float(tabArray.count))
        let itemHiehgt = bounds.size.height
        let item = UIView(frame: CGRect(x: self.bounds.size.width/CGFloat(Float(tabArray.count)/2), y:0, width:self.bounds.size.width/CGFloat(Float(tabArray.count)), height:self.bounds.size.height))
        addSubview(item)
//        let imageView = UIImageView()
//        imageView.snp.makeConstraints({(make) in
//            make.width.equalTo(20)
//            make.height.equalTo(20)
//            make.centerX.equalTo(CGFloat(Float(Int(itemWidth)/2*currentIndex)))
//            make.centerY.equalTo(itemHiehgt/2)
//
    
//        })
        let title = UILabel()
        addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemHiehgt)
            make.left.equalTo(item).offset(0)
            make.left.equalTo(item).offset(0)
        })
    }
}
