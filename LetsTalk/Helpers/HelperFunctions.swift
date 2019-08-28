//
//  HelperFunctions.swift
//  LetsTalk
//
//  Created by Aaron on 2019-08-27.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

//MARK: GLOBAL FUNCTIONS
private let dateFormat = "yyyyMMddHHmmss"

func dateFormatter() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
    
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter
}
