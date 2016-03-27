//
//  Banner.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-26.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class Banner: UIView {
    
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = UIColor.redColor()
        self.textLabel = UILabel(frame: CGRectMake(0.0, 0.0, self.frame.width, self.frame.height))
        self.textLabel.textColor = UIColor.whiteColor()
        self.textLabel.textAlignment = .Center
        self.textLabel.font = UIFont(name: "Avenir-Book", size: 14.0)
        self.addSubview(self.textLabel)
        self.backgroundColor = UIColor.redColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHiddenAnimated(hide: Bool) {
        
        if (hide) {
            self.alpha = 1.0
        } else {
            self.alpha = 0.0
            self.hidden = false
        }
        
        UIView.animateWithDuration(3.0, animations: { () -> Void in
            if (hide) {
                self.alpha = 0.0
            } else {
                self.alpha = 1.0
            }
            }) { (finished) -> Void in
                if (finished) {
                    self.hidden = hide
                }
        }
    }
}
