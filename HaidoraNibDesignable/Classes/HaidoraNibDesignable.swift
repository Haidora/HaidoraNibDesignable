//
//  HaidoraNibDesignable.swift
//  Pods
//
//  Created by Dailingchi on 16/9/13.
//
//

import UIKit

/** Designable
    * 直接实现该协议
 
     import HaidoraNibDesignable
     @IBDesignable
     class DesignableView: UIView,HaidoraNibDesignable {
     
         override init(frame: CGRect) {
         super.init(frame: frame)
         self.setupNib()
         }
         
         required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         self.setupNib()
         }
     }
    * 或者继承HaidoraNibDesignableView
 
     import HaidoraNibDesignable
     
     class InputView: HaidoraNibDesignableView {
     
     }
 */
public protocol HaidoraNibDesignable: class {

    /// 配置View的Nib,有默认实现
    func nibName() -> String
}

extension HaidoraNibDesignable where Self: UIView {
    
    public func nibName() -> String {
        return self.dynamicType.description().componentsSeparatedByString(".").last!
    }

    /// 根据nibName加载Nib
    public func loadNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: self.nibName(), bundle: bundle)
        return nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    }
    
    /// 添加Nib到当前View
    public func setupNib() {
        let view = self.loadNib()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options:[], metrics:nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options:[], metrics:nil, views: bindings))
    }
}

/**
    * xib设计时：是通过addSubView添加的
    * 运行时：内部通过awakeAfterUsingCoder替换生成的View
 */
@IBDesignable
public class HaidoraNibDesignableView: UIView, HaidoraNibDesignable {
    
    private var placeholderFlag = false
    
    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        #if TARGET_INTERFACE_BUILDER
        self.setupNib()
        #endif
    }
    
    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        #if TARGET_INTERFACE_BUILDER
        self.setupNib()
        #endif
    }
    
    public override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
        let placeHolderView: UIView = self
        #if !TARGET_INTERFACE_BUILDER
        if !placeholderFlag {
            placeholderFlag = true
            let view = self.loadNib()
            copyConstraints(self, realView: view)
            return view
        }
        placeholderFlag = false
        #endif
        return placeHolderView
    }
    
    private func copyConstraints(placeholderView: UIView, realView: UIView) {
        // Copy view's basic properties
        realView.frame = placeholderView.frame;
        realView.hidden = placeholderView.hidden;
        realView.tag = placeholderView.tag;
        
        // AutoresizingMasks follow placeholder view's
        realView.autoresizingMask = placeholderView.autoresizingMask;
        realView.translatesAutoresizingMaskIntoConstraints =
            placeholderView.translatesAutoresizingMaskIntoConstraints;
        for constraint in placeholderView.constraints {
            var newConstraint: NSLayoutConstraint?
            // "Height" or "Width" constraint
            // "self" as its first item, no second item
            if constraint.secondItem == nil {
                newConstraint = NSLayoutConstraint.init(item: realView, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: nil, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant)
            }
            // "Aspect ratio" constraint
            // "self" as its first AND second item
            else if constraint.firstItem.isEqual(constraint.secondItem) {
                newConstraint = NSLayoutConstraint.init(item: realView, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: realView, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant)
            }
            // Copy properties to new constraint
            if let newConstraint = newConstraint {
                newConstraint.shouldBeArchived = constraint.shouldBeArchived
                newConstraint.priority = constraint.priority
                newConstraint.identifier = constraint.identifier
                realView.addConstraint(newConstraint)
            }
        }
    }
}