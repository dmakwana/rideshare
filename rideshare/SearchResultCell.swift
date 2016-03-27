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
    var locationLabel = UILabel()
    var dateLabel = UILabel()
    var timeLabel = UILabel()
    var carLabel = UILabel()
    var ppImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
        
        self.searchResultCellView = UIView(frame: CGRect(x: -1.0, y: 0, width: self.frame.width + 2.0, height: 120))
        self.searchResultCellView.backgroundColor = UIColor.whiteColor()
        self.searchResultCellView.autoresizingMask = [.FlexibleWidth]
        self.searchResultCellView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.searchResultCellView.layer.borderWidth = 1.0
        
        self.driverNameLabel = UILabel(frame: CGRect(x: 15.0, y: 10, width: 300.0, height: 20.0))
        self.driverNameLabel.font = UIFont.boldSystemFontOfSize(16.0)
        
        self.locationLabel = UILabel(frame: CGRect(x: 15.0, y: 40.0, width: 300.0, height: 15.0))
        self.locationLabel.font = UIFont.systemFontOfSize(12.0)
        self.dateLabel = UILabel(frame: CGRect(x: 15.0, y: 65.0, width: 200.0, height: 15.0))
        self.dateLabel.font = UIFont.systemFontOfSize(12.0)
        self.timeLabel = UILabel(frame: CGRect(x: 150.0, y: 65.0, width: 100.0, height: 15.0))
        self.timeLabel.font = UIFont.systemFontOfSize(12.0)
        self.carLabel = UILabel(frame: CGRect(x: 15.0, y: 90.0, width: 100.0, height: 15.0))
        self.carLabel.font = UIFont.systemFontOfSize(12.0)
        self.ppImageView = UIImageView(frame: CGRect(x: self.contentView.frame.width - 30.0, y: 15.0, width: 70.0, height: 70.0 ))
        
        let layer = self.ppImageView.layer
        layer.cornerRadius = self.ppImageView.frame.size.width/2.0
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        
        self.searchResultCellView.addSubview(self.driverNameLabel)
        self.searchResultCellView.addSubview(self.locationLabel)
        self.searchResultCellView.addSubview(self.dateLabel)
        self.searchResultCellView.addSubview(self.timeLabel)
        self.searchResultCellView.addSubview(self.carLabel)
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
