//
//  ButtonBenefitViewModel.swift
//  TossBenefitTab
//
//  Created by 신희권 on 2023/03/29.
//

import Foundation

final class ButtonBenefitViewModel{
    
    @Published var benefit:Benefit = .today
    @Published var benefitDetails: BenefitDetails?
    
    init(benefit: Benefit) {
        self.benefit = benefit
    }

    func fetchDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.benefitDetails = .default
                
        }
        
    }
}
