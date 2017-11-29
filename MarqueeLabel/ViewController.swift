//
//  ViewController.swift
//  MarqueeLabel
//
//  Created by baye on 2017/11/29.
//  Copyright © 2017年 Heikki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ml = YXMarqueeLabel.init(frame: CGRect.init(x: 0, y: 88, width: self.view.frame.width, height: 100))
        ml.text = "只是重写了get方法，我们称这个属性为“计算性”属性，也就是只读属性"
        ml.play()
        self.view.addSubview(ml)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(10)) {
            ml.text = "你希望上拉的时候图片显示还是不显示？是 gif 还是文字？"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

