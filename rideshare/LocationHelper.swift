//
//  LocationHelper.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-26.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import Foundation

class LocationHelper {

    enum LocationPickerTag: Int {
        case StartLocPickerTag
        case EndLocPickerTag
    }
    
	func getActualRow(tag: LocationPickerTag, row : Int, startIdx: Int, endIdx: Int) -> Int {
	    var idx = -1
	    if (tag == LocationPickerTag.StartLocPickerTag) {
	        idx  = endIdx
	    } else {
	        idx = startIdx
	    }
	    if (idx != -1) {
	        if (row < idx) {
	            return row
	        } else {
	            return row + 1
	        }
	    } else {
	        return row
	    }
	}

    func getActualString(tag: LocationPickerTag, row : Int, startIdx: Int, endIdx: Int, locationArray: [String]) -> String {
	    var idx = -1
	    if (tag == LocationPickerTag.StartLocPickerTag) {
	        idx  = endIdx
	    } else {
	        idx = startIdx
	    }
	    if (idx == -1) {
	        return String(locationArray[row])
	    } else {
	        if (row < idx) {
	            return String(locationArray[row])
	        } else {
	            return String(locationArray[row + 1])
	        }
	    }
	}

    func getActualSize(tag: LocationPickerTag, startIdx: Int, endIdx: Int, locArrayLength: Int) -> Int {
	    var idx = -1
	    if (tag == LocationPickerTag.StartLocPickerTag) {
	        idx  = endIdx
	    } else {
	        idx = startIdx
	    }
	    if (idx == -1) {
	        return locArrayLength
	    } else {
	        return (locArrayLength - 1)
	    }
	}
}


