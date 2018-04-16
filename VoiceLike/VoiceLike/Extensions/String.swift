//
//  String.swift
//  VoiceLike
//
//  Created by Alessio Papazzoni on 01/02/18.
//  Copyright © 2018 bussolalabs. All rights reserved.
//

import Foundation

extension String {
    
    static var empty: String { return "" }
    
    var localized: String {
        return NSLocalizedString(self, comment: String.empty)
    }
    
}
