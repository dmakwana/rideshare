//
//  SearchResultCell.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-26.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    var searchResultCellView = UIView()
    var driverNameLabel = UILabel()
    var startLabel = UILabel()
    var endLabel = UILabel()
    var dateLabel = UILabel()
    var timeLabel = UILabel()
    var ppImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
        
        self.searchResultCellView = UIView(frame: CGRect(x: -1.0, y: 0, width: self.frame.width + 2.0, height: 100))
        self.searchResultCellView.backgroundColor = UIColor.whiteColor()
        self.searchResultCellView.autoresizingMask = [.FlexibleWidth]
        self.searchResultCellView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.searchResultCellView.layer.borderWidth = 1.0
        
        self.driverNameLabel = UILabel(frame: CGRect(x: 15.0, y: 10, width: 300.0, height: 20.0))
        self.startLabel = UILabel(frame: CGRect(x: 15.0, y: 40.0, width: 100.0, height: 20.0))
        self.endLabel = UILabel(frame: CGRect(x: 150.0, y: 40, width: 100.0, height: 20.0))
        self.dateLabel = UILabel(frame: CGRect(x: 15.0, y: 70.0, width: 200.0, height: 20.0))
        self.timeLabel = UILabel(frame: CGRect(x: 150.0, y: 70.0, width: 100.0, height: 20.0))
        self.ppImageView = UIImageView(frame: CGRect(x: self.contentView.frame.width - 30.0, y: 15.0, width: 70.0, height: 70.0 ))
        
        let layer = self.ppImageView.layer
        layer.cornerRadius = self.ppImageView.frame.size.width/2.0
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        
        self.searchResultCellView.addSubview(self.driverNameLabel)
        self.searchResultCellView.addSubview(self.startLabel)
        self.searchResultCellView.addSubview(self.endLabel)
        self.searchResultCellView.addSubview(self.dateLabel)
        self.searchResultCellView.addSubview(self.timeLabel)
        self.searchResultCellView.addSubview(self.ppImageView)
        self.contentView.addSubview(self.searchResultCellView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageForCell(url: String!) {
        let image = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
        self.ppImageView.image = image
    }
}
