//
//  ASMTImageInfo.swift
//  ASMToast
//
//  Created by Amit on 8/9/20.
//

import Foundation
import UIKit

public class ASMTImageInfo {
    public var image: UIImage?
    public var imageViewWidth: CGFloat?
    public var imageViewHeight: CGFloat?
    
    public init(_ image: UIImage?, _ imageViewWidth: CGFloat?, _ imageViewHeight: CGFloat?) {
        self.image = image
        self.imageViewWidth = imageViewWidth
        self.imageViewHeight = imageViewHeight
    }
}
