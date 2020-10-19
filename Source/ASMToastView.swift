//
//  ASToastView.swift
//  superapp
//
//  Created by Amit on 5/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public class ASMToastView: UIView {
    var myScrollView: UIScrollView?
    var myStackView: UIStackView?
    var container: UIView?
    var imageView: UIImageView?
    var messageLabel: UILabel?
    var iscCornerRadius = true
    var paddingX: CGFloat = 8
    var paddingY: CGFloat = 8
    var message: String?
    var props: ASMTProps?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public init(_ message: String?, _ props: ASMTProps? = nil) {
        super.init(frame: CGRect.zero)
        self.message = message
        self.props = props
        self.paddingX = props?.padding?.paddingX ?? 8
        self.paddingY = props?.padding?.paddingY ?? 8
        setup()
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if iscCornerRadius {
            if props?.isCornerRadius50P ?? false {
                let cornerRadius: CGFloat = (self.bounds.size.height) * 0.5
                container?.layer.cornerRadius = cornerRadius
            }else {
                let cornerRadius: CGFloat = 10 //(container?.bounds.size.height ?? 0 - padding*2) * 0.5
                container?.layer.cornerRadius = cornerRadius
            }
            myScrollView?.contentSize = CGSize(width: myScrollView?.bounds.width ?? 0, height: myStackView?.bounds.height ?? 0)
        }
    }
    
    public func setup() {
        setupUIElements()
        setupConstraints()
    }
    
    public func setupUIElements() {
        backgroundColor = props?.backgroundColor ?? UIColor.clear
        
        myScrollView = UIScrollView()
        addSubview(myScrollView.unsafelyUnwrapped)
        myScrollView?.isUserInteractionEnabled = true
        myScrollView?.backgroundColor = .clear
        myScrollView?.showsHorizontalScrollIndicator = false
        myScrollView?.showsVerticalScrollIndicator = false
        myScrollView?.isScrollEnabled=true
        myScrollView?.bounces = true
        myScrollView?.bouncesZoom = true
        myScrollView?.alwaysBounceVertical = false
        myScrollView?.alwaysBounceHorizontal = false
        
        myStackView = UIStackView()
        myScrollView?.addSubview(myStackView.unsafelyUnwrapped)
        myStackView?.backgroundColor = .clear
        myStackView?.axis = .vertical
        
        container = UIView()
        myStackView?.addArrangedSubview(container.unsafelyUnwrapped)
        container?.layer.rasterizationScale = UIScreen.main.scale
        container?.layer.shouldRasterize = true
        container?.backgroundColor = props?.containerBackgroundColor ?? UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.7)
        setBordeColor(UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0))
        setBordeWidth(1.0)
        
        imageView = UIImageView()
        container?.addSubview(imageView.unsafelyUnwrapped)
        imageView?.contentMode = .scaleAspectFit
        if let image = props?.imageInfo?.image {
            imageView?.image = image
        } 
        
        messageLabel = UILabel()
        container?.addSubview(messageLabel.unsafelyUnwrapped)
        messageLabel?.numberOfLines = props?.numberOfLines ?? 0
        messageLabel?.font = props?.font ?? UIFont.systemFont(ofSize: 15)
        messageLabel?.textColor = props?.textColor ?? .white
        messageLabel?.textAlignment = props?.textAlignment ?? .center
        messageLabel?.text = message ?? ""
    }
    
    public func setupConstraints() {
        if #available(iOS 11.0, *) {
            myScrollView?.translatesAutoresizingMaskIntoConstraints = false
            myScrollView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
            myScrollView?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            myScrollView?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            myScrollView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            myStackView?.translatesAutoresizingMaskIntoConstraints = false
            myStackView?.topAnchor.constraint(equalTo: myScrollView.unsafelyUnwrapped.topAnchor).isActive = true
            myStackView?.leftAnchor.constraint(equalTo: myScrollView.unsafelyUnwrapped.leftAnchor).isActive = true
            myStackView?.rightAnchor.constraint(equalTo: myScrollView.unsafelyUnwrapped.rightAnchor).isActive = true
            myStackView?.bottomAnchor.constraint(equalTo: myScrollView.unsafelyUnwrapped.bottomAnchor).isActive = true
            myStackView?.widthAnchor.constraint(equalTo: myScrollView.unsafelyUnwrapped.widthAnchor).isActive = true
            let heightConstraint = myStackView?.heightAnchor.constraint(equalTo: myScrollView.unsafelyUnwrapped.heightAnchor)
            heightConstraint?.priority = UILayoutPriority(rawValue: 250)
            heightConstraint?.isActive = true
            
            container?.translatesAutoresizingMaskIntoConstraints = false
            container?.widthAnchor.constraint(equalTo: self.myStackView.unsafelyUnwrapped.widthAnchor).isActive = true
            let subBackViewHeightConstraint = container?.heightAnchor.constraint(lessThanOrEqualTo: self.myScrollView.unsafelyUnwrapped.heightAnchor)
            subBackViewHeightConstraint?.priority = UILayoutPriority(rawValue: 250)
            subBackViewHeightConstraint?.isActive = true
            
            imageView?.translatesAutoresizingMaskIntoConstraints = false
            imageView?.topAnchor.constraint(equalTo: container.unsafelyUnwrapped.topAnchor, constant: paddingY).isActive = true
            imageView?.leftAnchor.constraint(equalTo: container.unsafelyUnwrapped.leftAnchor, constant: (props?.imageInfo?.imageViewWidth ?? 0) > 0 ? paddingX : 0).isActive = true
            imageView?.bottomAnchor.constraint(equalTo: container.unsafelyUnwrapped.bottomAnchor, constant: -paddingY).isActive = true
            imageView?.widthAnchor.constraint(equalToConstant: props?.imageInfo?.imageViewWidth ?? 0).isActive = true
            if let imageViewHeight = props?.imageInfo?.imageViewHeight {
                imageView?.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
            }
            
            messageLabel?.translatesAutoresizingMaskIntoConstraints = false
            messageLabel?.topAnchor.constraint(equalTo: container.unsafelyUnwrapped.topAnchor, constant: paddingY).isActive = true
            messageLabel?.leftAnchor.constraint(equalTo: imageView.unsafelyUnwrapped.rightAnchor, constant: paddingX).isActive = true
            messageLabel?.rightAnchor.constraint(equalTo: container.unsafelyUnwrapped.rightAnchor, constant: -paddingX).isActive = true
            messageLabel?.bottomAnchor.constraint(equalTo: container.unsafelyUnwrapped.bottomAnchor, constant: -paddingY).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }
}

@available(iOS 9.0, *)
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
