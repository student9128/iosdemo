//
//  UIKitStudyViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/23.
//

import Foundation
import UIKit
class UIKitListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    var array:NSArray=["UILabel","UIButton"]
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
        print("path=\(indexPath),\(indexPath.row),\(indexPath.section),\(indexPath.count),\(indexPath.startIndex)")
        cell?.setContent(array.object(at: indexPath.section) as? String ?? "")
        cell?.setAvatar("头像\(indexPath.section)")
//        cell?.textLabel?.text=array.object(at: indexPath.section) as? String
//        cell?.textLabel?.textColor=UIColor.white
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("UIKitListViewController")
        view.backgroundColor=UIColor.blue
        let tableView = UITableView(frame: self.view.frame, style: UITableView.Style.plain)
    
        view.addSubview(tableView)
        tableView.snp.makeConstraints({(make)in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        tableView.delegate=self
        tableView.dataSource=self
    }
}
