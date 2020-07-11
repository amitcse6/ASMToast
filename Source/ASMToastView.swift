//
//  ASToastView.swift
//  superapp
//
//  Created by Amit on 5/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public class ASMToastView: UIView {
    var container: UIView?
    var messageLabel: UILabel?
    var iscCornerRadius = true
    var padding: CGFloat = 8
    var message: String?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public init(_ message: String?) {
        super.init(frame: CGRect.zero)
        self.message = message
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if iscCornerRadius {
            let cornerRadius = (container?.bounds.size.height ?? 0 - padding*2) * 0.5
            container?.layer.cornerRadius = cornerRadius
        }
    }
    
    public func setup() {
        setupUIElements()
        setupConstraints()
    }
    
    public func setupUIElements() {
        container = UIView()
        addSubview(self.container.unsafelyUnwrapped)
        container?.layer.rasterizationScale = UIScreen.main.scale
        container?.layer.shouldRasterize = true
        container?.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.7)
        setBordeColor(UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0))
        setBordeWidth(1.0)

        messageLabel = UILabel()
        container?.addSubview(self.messageLabel.unsafelyUnwrapped)
        messageLabel?.font = UIFont.systemFont(ofSize: 15)
        messageLabel?.textColor = .white
        messageLabel?.textAlignment = .center
        messageLabel?.text = message ?? ""
    }
    
    public func setupConstraints() {
        container?.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            container?.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
            container?.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
            container?.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
            container?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
            
            messageLabel?.translatesAutoresizingMaskIntoConstraints = false
            messageLabel?.topAnchor.constraint(equalTo: container.unsafelyUnwrapped.topAnchor, constant: padding).isActive = true
            messageLabel?.leftAnchor.constraint(equalTo: container.unsafelyUnwrapped.leftAnchor, constant: padding).isActive = true
            messageLabel?.rightAnchor.constraint(equalTo: container.unsafelyUnwrapped.rightAnchor, constant: -padding).isActive = true
            messageLabel?.bottomAnchor.constraint(equalTo: container.unsafelyUnwrapped.bottomAnchor, constant: -padding).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }
}

extension ASMToastView {
    @discardableResult
    public func setBorderWith(borderColor:UIColor, borderWidth:CGFloat) -> ASMToastView {
        container?.layer.borderColor = borderColor.cgColor
        container?.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func setBordeColor(_ borderColor: UIColor) -> ASMToastView {
        container?.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    func setBordeWidth(_ borderWidth: CGFloat) -> ASMToastView {
        container?.layer.borderWidth = borderWidth
        return self
    }
}
