//
//  FourthViewController.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/14.
//

import Foundation
import SnapKit
import UIKit
class FourthViewController : UIViewController,UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID="testID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if(cell==nil){
            cell = UITableViewCell(style:.default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text="测试\(indexPath)"
        return cell!

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="第四"
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints({(make)in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        tableView.delegate=self
        tableView.dataSource=self
    }
}
