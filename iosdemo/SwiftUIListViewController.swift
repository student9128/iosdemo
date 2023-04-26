//
//  SwiftUIListViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/23.
//

import Foundation
import UIKit
class SwiftUIListViewController:UIViewController{
    var array:NSArray=["Text","Button","Image","ProgressView","VStack","HStack","ZStack","Group","LazyStack","Slider","Stepper","Picker","Toggle","LoadingView","Form","List","Shape","Tables","Scroll views","Toolbars","Navigation","Animations"]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SwiftUIListViewController")
        view.backgroundColor=UIColor.green
        let listView = ListView(frame: self.view.frame, style: UITableView.Style.plain)
        listView.initListView(data: array)
        view.addSubview(listView)
//        listView.reloadData()
        listView.snp.makeConstraints({make in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
    }
}
