//
//  TableCellModel.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/23.
//

import Foundation
import SwiftUI
class TabCellModel:ObservableObject{
    @Published var avatar:String=""
    @Published var content:String=""
    @Published var color:Color=Color.clear
}
