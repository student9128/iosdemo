//
//  ListView.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/25.
//

import Foundation
import UIKit
import SwiftUI
class ListView:UITableView,UITableViewDelegate,UITableViewDataSource{
    var array:NSArray = []
//    let arr=Array<String>()
    func initListView(data:NSArray){
//        let temop = array as![String]
//        let arr=temop+data as![String]
//        print(arr)
        array=data
        reloadData()
    }
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame:frame, style: style)
        self.delegate=self
        self.dataSource=self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID="UIKitWidgetNameList"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CustomTabViewCell
        if(cell==nil){
//            cell=UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
            cell = CustomTabViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.backgroundColor=UIColor(red:CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha:1.0)
//        print("path=\(indexPath),\(indexPath.row),\(indexPath.section),\(indexPath.count),\(indexPath.startIndex)")
        cell?.selectedBackgroundView=UIView()
        cell?.selectedBackgroundView?.backgroundColor=UIColor.systemBlue
        cell?.setContent(array.object(at: indexPath.section) as? String ?? "")
        cell?.setAvatar("\(indexPath.section)")
        cell?.setColor(Color.random())
//        cell?.textLabel?.text=array.object(at: indexPath.section) as? String
//        cell?.textLabel?.textColor=UIColor.white
        print("\(array.count)")
        return cell!
    }
    
    
}
