//
//  File.swift
//  TossBenefitTab
//
//  Created by 신희권 on 2023/03/27.
//

import Foundation

struct TodaySectionItem{
    var point: MyPoint
    var today: Benefit
    
    var sectionItems: [AnyHashable]  {
        return [point, today]
    }
}

extension TodaySectionItem{
    static let mock = TodaySectionItem (
        point: MyPoint(point: 0),
        today: Benefit.walk)
}
