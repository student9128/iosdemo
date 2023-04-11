//
//  MGSLabel.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/9.
//

import Foundation
import UIKit

class MGSLabel: UILabel {
  var textInsets: UIEdgeInsets = .zero
  
  override func drawText(in rect: CGRect) {
//    super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
      super.drawText(in: rect)
  }
  
  override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    let insets = textInsets
//    var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets),
//                              limitedToNumberOfLines: numberOfLines)
      var rect = super.textRect(forBounds:bounds, limitedToNumberOfLines:numberOfLines)
    
    rect.origin.x -= insets.left
    rect.origin.y -= insets.top
    rect.size.width += (insets.left + insets.right)
    rect.size.height += (insets.top + insets.bottom)
    return rect
  }
}
