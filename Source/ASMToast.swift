//
//  ASToast.swift
//  superapp
//
//  Created by Amit on 5/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public enum ASMToastAlignment: String {
    case center
    case top
    case bottom
}

@available(iOS 9.0, *)
public class ASMToast: NSObject {
    static var sharedManager: ASMToast?
    public static var toastAlignment: ASMToastAlignment = ASMToastAlignment.bottom
    
    @discardableResult
    static func shared() -> ASMToast? {
        if sharedManager == nil {
            sharedManager = ASMToast()
        }
        return sharedManager
    }
    
    private override init() {
    }
    
    var toastView: ASMToastView?
    var rootPadding: CGFloat = 16
    var withDuration: TimeInterval = 3
    var delay: TimeInterval = 1
    
    private func show(_ message: String?,  _ props: ASMTProps? = nil) {
        if let viewController = ASMToast.topMostVC {
            toastView = ASMToastView(message, props)
            viewController.view.addSubview(toastView.unsafelyUnwrapped)
            
            if #available(iOS 11.0, *) {
                toastView?.translatesAutoresizingMaskIntoConstraints = false
                if props?.isToHororozontalEdge ?? false {
                    toastView?.leftAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leftAnchor, constant: rootPadding).isActive = true
                    toastView?.rightAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.rightAnchor, constant: -rootPadding).isActive = true
                }
                
                switch props?.toastAlignment ?? ASMToast.toastAlignment {
                case .center:
                    toastView?.topAnchor.constraint(greaterThanOrEqualTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: rootPadding).isActive = true
                    toastView?.bottomAnchor.constraint(lessThanOrEqualTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -rootPadding).isActive = true
                    toastView?.centerYAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
                case .top:
                    toastView?.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: rootPadding).isActive = true
                    toastView?.bottomAnchor.constraint(lessThanOrEqualTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -rootPadding).isActive = true
                case .bottom:
                    toastView?.topAnchor.constraint(greaterThanOrEqualTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: rootPadding).isActive = true
                    toastView?.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -rootPadding).isActive = true
                }
                toastView?.leftAnchor.constraint(greaterThanOrEqualTo: viewController.view.safeAreaLayoutGuide.leftAnchor, constant: rootPadding).isActive = true
                toastView?.rightAnchor.constraint(lessThanOrEqualTo: viewController.view.safeAreaLayoutGuide.rightAnchor, constant: -rootPadding).isActive = true
                toastView?.centerXAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
                
                let gesture = ASMToastGestureRecognizer(target: self, action: #selector(onTap))
                gesture.numberOfTapsRequired = 1
                toastView?.addGestureRecognizer(gesture)
                toastView?.isUserInteractionEnabled = true
            } else {
                // Fallback on earlier versions
            }
            dismissWithAnimation(toastView)
        }
    }
    
    @objc func onTap(sender : AnyObject){
        dismiss(toastView)
    }
    
    private func dismiss(_ toastView: ASMToastView?) {
        var toastView = toastView
        toastView?.container?.layer.removeAllAnimations()
        toastView?.removeFromSuperview()
        toastView = nil
    }
    
    @objc private func dismissWithAnimation(_ toastView: ASMToastView?) {
        UIView.animate(withDuration: withDuration, delay: delay, options: [.allowUserInteraction, .curveEaseIn], animations: { () -> Void in
            toastView?.container?.alpha = 0
        }, completion: { (finished) in
            self.dismiss(toastView)
        })
    }
}

@available(iOS 9.0, *)
extension ASMToast {
    public static func show(_ message: String?, _ props: ASMTProps? = nil) {
        if let toast = ASMToast.shared() {
            ASMToast.dismiss()
            toast.show(message, props)
        }
    }
    
    public static func dismiss() {
        if let toast = ASMToast.shared() {
            toast.dismiss(toast.toastView)
        }
    }
    
    private static var topMostVC: UIViewController? {
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        if presentedVC == nil {
            print("Error: You don't have any views set.")
        }
        return presentedVC
    }
}

public class ASMToastGestureRecognizer: UITapGestureRecognizer {
    var firstObject: Any?
    
    func setFirstObject(_ sender: Any?) {
        self.firstObject = sender
    }
    
    func getFirstObject() -> Any? {
        return self.firstObject
    }
}
