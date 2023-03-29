//
//  MyPointViewModel.swift
//  TossBenefitTab
//
//  Created by 신희권 on 2023/03/29.
//

import Foundation
import Combine

final class MyPointViewModel {
    @Published var point:MyPoint
    
    init(point: MyPoint) {
        self.point = point
    }
}
