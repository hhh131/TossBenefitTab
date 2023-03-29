//
//  BenefitListViewModel.swift
//  TossBenefitTab
//
//  Created by 신희권 on 2023/03/29.
//

import Foundation
import Combine

final class BenefitListViewModel{
    @Published var todaySectionItems: [AnyHashable] = []
    @Published var otherSectionItems: [AnyHashable] = []
 // User Interaction
    
    let benefitDidTapped = PassthroughSubject<Benefit,Never>()
    let MypointDidTapped = PassthroughSubject<MyPoint,Never>()
    
    func fetchItmes() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.todaySectionItems = TodaySectionItem(point: .default, today: .today).sectionItems
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.otherSectionItems = Benefit.others
        }
    }
}
