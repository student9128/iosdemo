//
//  UIImageExtension.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/23.
//

import Foundation
import  UIKit
 
extension  UIImage  {
     /**
      *  重设图片大小
      */
     func  reSizeImage(reSize: CGSize )-> UIImage?  {
         //UIGraphicsBeginImageContext(reSize);
         UIGraphicsBeginImageContext(reSize)
//         UIGraphicsBeginImageContextWithOptions (reSize, false , UIScreen.mainScreen().scale);
         self.draw(in: CGRectMake (0, 0, reSize.width, reSize.height));
         let  reSizeImage: UIImage?  =  UIGraphicsGetImageFromCurrentImageContext ();
         UIGraphicsEndImageContext ();
         return  reSizeImage;
     }
     
     /**
      *  等比率缩放
      */
     func  scaleImage(scaleSize: CGFloat )-> UIImage?  {
         let  reSize =  CGSizeMake ( self .size.width * scaleSize,  self .size.height * scaleSize)
         return  reSizeImage(reSize: reSize)
     }
}
