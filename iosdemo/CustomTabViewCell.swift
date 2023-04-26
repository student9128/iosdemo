//
//  CustomTabViewCell.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/23.
//

import Foundation
import UIKit
import SwiftUI
class CustomTabViewCell:UITableViewCell{
    private var tabCellModel = TabCellModel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        let listViewItem=ListViewItem(tabCellModel: tabCellModel).environmentObject(tabCellModel) 将UIHostingController 的参数改为listViewItem
        
        let tabCell = CustomTabViewCellBySwiftUI()
        let cell = tabCell.customTabViewCell(tabCellModel: tabCellModel)
        self.addSubview(cell.view)
        cell.view.snp.makeConstraints({make in
//            make.width.equalTo(200)
//            make.height.equalTo(50)
//            make.height.equalTo(50)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(self).offset(15)
//            make.bottom.equalTo(self)
        })
        cell.view.backgroundColor=UIColor.clear
        //可以通过这个赋值
//        UserDefaults.standard.set(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setAvatar(_ avatar:String){
        tabCellModel.avatar=avatar
    }
    func setContent(_ content:String){
        tabCellModel.content=content
    }
    func setColor(_ color:Color){
        tabCellModel.color=color
    }
    
}
