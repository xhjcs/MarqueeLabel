//
//  YXMarqueeView.swift
//  MarqueeLabel
//
//  Created by baye on 2017/11/29.
//  Copyright © 2017年 Heikki. All rights reserved.
//

import UIKit

class YXMarqueeLabel: UIView {
    
    let animationKey = "com.heikki.marquee.label.animation"

    var label1 = UILabel()
    var label2 = UILabel()
    
    var text: String? {
        didSet {
            label1.text = self.text
            label2.text = self.text
            if self.text == nil {
                return
            }
            let textWidth = self.text!.width(withConstraintedHeight: self.frame.height, font: self.font) + 5
            self.label1.frame = CGRect.init(x: 0, y: 0, width: textWidth, height: self.frame.height)
            if self.label1.frame.width < self.frame.width {
                self.label2.isHidden = true
                return
            }
            self.label2.isHidden = false
            self.label2.frame = CGRect.init(x: textWidth + 24, y: 0, width: textWidth, height: self.frame.height)
        }
    }
    
    var textColor: UIColor! {
        didSet {
            label1.textColor = textColor
            label2.textColor = textColor
        }
    }
    
    var font: UIFont! {
        didSet {
            label1.font = self.font
            label2.font = self.font
        }
    }
    
    lazy var animation: CABasicAnimation = {
        let animation = CABasicAnimation.init(keyPath: "transform")
        animation.repeatCount = .greatestFiniteMagnitude
        animation.isRemovedOnCompletion = false
        return animation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .gray
        self.font = UIFont.systemFont(ofSize: 16.0)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(self.label1)
        self.label1.textColor = self.textColor
        self.label1.font = self.font
        
        self.addSubview(self.label2)
        self.label2.textColor = self.textColor
        self.label2.font = self.font
    }
    
    func play() {
        self.pause()
        guard self.label1.frame.width > self.frame.width else { return }
        self.animation.toValue = NSValue.init(caTransform3D: CATransform3DMakeTranslation(-self.label2.frame.minX, 0, 0))
        self.animation.duration = CFTimeInterval(self.label1.frame.width) * 0.04
        self.label1.layer.add(self.animation, forKey: animationKey)
        self.label2.layer.add(self.animation, forKey: animationKey)
    }
    
    func pause() {
        self.label1.layer.removeAnimation(forKey: animationKey)
        self.label2.layer.removeAnimation(forKey: animationKey)
    }
}

extension String {
    func width(withConstraintedHeight height:CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize.init(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        return ceil(boundingBox.width)
    }
}
