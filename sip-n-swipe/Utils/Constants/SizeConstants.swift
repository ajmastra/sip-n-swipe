//
//  SizeConstants.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import SwiftUI

struct SizeConstants {
    
    // screencutoff value for swiping
    static var screenCutoff: CGFloat {
        (UIScreen.main.bounds.width / 2) * 0.8
    }
    
    static var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    static var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.45
    }
    
}
