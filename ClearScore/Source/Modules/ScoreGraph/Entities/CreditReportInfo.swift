//
//  CreditReport.swift
//  ClearScore
//
//  Created by luca silvestro on 04/03/18.
//  Copyright © 2018 Clear Score. All rights reserved.
//

import Foundation
import ObjectMapper

struct CreditReportInfo: Mappable {
    
    /// Current score
    var score: Float = 0.0
    
    /// Minimum score
    var minScore: Float = 0.0
    
    /// Maximum score
    var maxScore: Float = 0.0
    
    /// Relative Value representing current score as fraction of the maximum score. This value must be in range of 0.0 and 1.0.
    var percentage: Float {
        guard maxScore > 0 else {
                return 0
        }
        
        return score / maxScore
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        score <- map["creditReportInfo.score"]
        minScore <- map["creditReportInfo.minScoreValue"]
        maxScore <- map["creditReportInfo.maxScoreValue"]
    }
}
