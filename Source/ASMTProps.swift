//
//  ASMTProps.swift
//  ASMToast
//
//  Created by Amit on 8/9/20.
//

import Foundation
import UIKit

public class ASMTProps {
    public var backgroundColor: UIColor?
    public var containerBackgroundColor: UIColor?
    public var textColor: UIColor?
    public var font: UIFont?
    public var numberOfLines: Int?
    public var textAlignment: NSTextAlignment?
    public var toastAlignment: ASMToastAlignment?
    
    
    public init(_ backgroundColor: UIColor?, _ containerBackgroundColor: UIColor?, _ textColor: UIColor?, _ font: UIFont, _ numberOfLines: Int?, _ textAlignment: NSTextAlignment?, _ toastAlignment: ASMToastAlignment?) {
        self.backgroundColor = backgroundColor
        self.containerBackgroundColor = containerBackgroundColor
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.toastAlignment = toastAlignment
    }
    
    public init(_ containerBackgroundColor: UIColor?, _ textColor: UIColor?, _ font: UIFont, _ numberOfLines: Int?, _ textAlignment: NSTextAlignment?, _ toastAlignment: ASMToastAlignment?) {
        self.containerBackgroundColor = containerBackgroundColor
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
    
    public init(_ textColor: UIColor?, _ font: UIFont, _ numberOfLines: Int?, _ textAlignment: NSTextAlignment?) {
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
    
    
    public init(_ backgroundColor: UIColor?, _ containerBackgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        self.containerBackgroundColor = containerBackgroundColor
    }
    
    public init(_ containerBackgroundColor: UIColor?) {
        self.containerBackgroundColor = containerBackgroundColor
    }
    
    public init(_ toastAlignment: ASMToastAlignment?) {
        self.toastAlignment = toastAlignment
    }
}
