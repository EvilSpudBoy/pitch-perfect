//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Michael Stevens on 3/28/15.
//  Copyright (c) 2015 Michael Stevens. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    
    var title: String!
    
    init(title:String, filePathUrl:NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
    
}