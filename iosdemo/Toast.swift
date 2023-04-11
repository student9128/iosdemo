//
//  Toast.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/9.
//

import Foundation
import UIKit
import SnapKit

enum Toast {
  static func toast(at view: UIView, message: String, completion: (() -> Void)? = nil) {
    let toastLabel = MGSLabel(frame: .zero)
    toastLabel.text = "  \(message)  "
    toastLabel.numberOfLines = 0
    toastLabel.font = UIFont.systemFont(ofSize: 15.0)
//    toastLabel.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
      toastLabel.backgroundColor = UIColor.green.withAlphaComponent(0.8)
    toastLabel.textColor = .white
    toastLabel.textAlignment = .center
    toastLabel.layer.cornerRadius = 7.0
    toastLabel.layer.masksToBounds = true
    toastLabel.textInsets = UIEdgeInsets(top: 5.0, left: 0, bottom: 5.0, right: 0)

    view.addSubview(toastLabel)
    toastLabel.setContentHuggingPriority(.init(rawValue: 750.0), for: .horizontal)
    toastLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(10.0)
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      toastLabel.removeFromSuperview()
      completion?()
    }
  }
}
