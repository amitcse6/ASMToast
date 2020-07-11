//
//  ASToast.swift
//  superapp
//
//  Created by Amit on 5/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public class ASMToast: NSObject {
    static var sharedManager: ASMToast?
    
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
    
    private func show(_ message: String?) {
        if let viewController = ASMToast.topMostVC {
            toastView = ASMToastView(message)
            viewController.view.addSubview(toastView.unsafelyUnwrapped)
            toastView?.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11.0, *) {
                let leftAnchor = toastView?.leftAnchor.constraint(lessThanOrEqualTo: viewController.view.safeAreaLayoutGuide.leftAnchor, constant: rootPadding)
                leftAnchor?.priority = UILayoutPriority(rawValue: 250)
                leftAnchor?.isActive = true
                let rightAnchor = toastView?.rightAnchor.constraint(lessThanOrEqualTo: viewController.view.safeAreaLayoutGuide.rightAnchor, constant: -rootPadding)
                rightAnchor?.priority = UILayoutPriority(rawValue: 250)
                rightAnchor?.isActive = true
                toastView?.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -rootPadding).isActive = true
                toastView?.centerXAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
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
        UIView.animate(withDuration: withDuration, delay: delay, options: [.allowUserInteraction], animations: { () -> Void in
            toastView?.container?.alpha = 0
        }, completion: { (finished) in
            self.dismiss(toastView)
        })
    }
}

extension ASMToast {
    public static func show(_ message: String?) {
        if let toast = ASMToast.shared() {
            ASMToast.dismiss()
            toast.show(message)
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
