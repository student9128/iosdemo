//
//  UIKitStudyViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/23.
//

import Foundation
import UIKit
import SwiftUI
class UIKitListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    var array:NSArray=["UILabel","UIButton","UITextField","UITextView","UIToolBar","UINavigationBar","UITabBarController","UISegmentedControl","UITableView","UICollectionView","UISlider","UIDatePicker","UISwitch","UIImageView","UIWebView","UIScrollView","Stack View","AVAudioPlayer","MPMoviePlayerController"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    //这个里设置粘性头部
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor=UIColor.cyan
//        return headerView
//    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor=UIColor.red
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID="UIKitWidgetNameList"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CustomTabViewCell
        if(cell==nil){
            //            cell=UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
            cell = CustomTabViewCell(style: .default, reuseIdentifier: cellID)
        }
//        cell?.backgroundColor=UIColor(red:CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha:1.0)
        cell?.backgroundColor = UIColor(hex:"#FFF0DC")
        //        print("path=\(indexPath),\(indexPath.row),\(indexPath.section),\(indexPath.count),\(indexPath.startIndex)")
        cell?.selectedBackgroundView=UIView()
        cell?.selectedBackgroundView?.backgroundColor=UIColor.systemBlue
        cell?.selectionStyle = .none
//        cell?.selectedBackgroundView?.layoutMargins =  UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
//        cell?.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0)
//        cell?.separatorInset = UIEdgeInsets(top: 0, left:15, bottom: 0, right: 15)
        let content: String = array.object(at: indexPath.section) as? String ?? ""
        cell?.setContent(content)
        cell?.setAvatar("\(indexPath.section)")
        cell?.setColor(Color.random())
        cell?.onTapAction={
            print("点击了\(indexPath.section),\(content)")
            self.handleClickAction(label: "\(content)")
            
        }
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("UIKitListViewController")
        view.backgroundColor=UIColor.white
        let tableView = UITableView(frame: self.view.frame, style: UITableView.Style.plain)
        view.addSubview(tableView)
        tableView.snp.makeConstraints({(make)in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        })
        tableView.separatorStyle = .none
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.white //底色一定要设置
//        tableView.sectionHeaderHeight = 100
//        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)//内容的不是每个cell之间的
        tableView.sectionHeaderTopPadding=0
        
        tableView.delegate=self
        tableView.dataSource=self
    }
    func handleClickAction(label:String){
        var vc:UIViewController?
        switch label{
        case "UILabel":
            vc=UILabelViewController()
            //            self.navigationController?.pushViewController(lableVc, animated: true)
            break
        case "UIButton":
            vc=UIButtonController()
            break
        case "UITextField":
            break
        case "UITextView":
            break
        case "UIToolBar":
            break
        default:
            break
        }
        if let temp=vc{
            print("不为null")
            self.navigationController?.pushViewController(temp, animated: true)
        }else{
            print("为null")
        }
    }
}
