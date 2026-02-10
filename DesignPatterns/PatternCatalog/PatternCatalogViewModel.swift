//
//  PatternCatalogViewModel.swift
//  DesignPatterns
//
//  Created Gabriel Alejandro Briseño Alvarez on 08/02/26.
//  Copyright © 2026 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//

import Foundation

protocol PatternCatalogViewModelProtocol {
    var sections: [PatternCatalog] { get }

    func tryMeButtonTapped(at pattern: any PatternItemKeys)
}

@Observable
class PatternCatalogViewModel: PatternCatalogViewModelProtocol {
    private(set) var sections: [PatternCatalog] = [
        PatternData.poo_pillars,
        PatternData.poo_pillars,
        PatternData.poo_pillars,
        PatternData.poo_pillars,
        PatternData.poo_pillars
    ]
    
    func tryMeButtonTapped(at pattern: any PatternItemKeys) {
        switch pattern {
        case let poo_pillars as PatternCatalog.POOPillar:
            switch poo_pillars {
            case .abstraction: break
            case .encapsulation: break
            case .inheritance: break
            case .polymorphism: break
            }
        default: break
        }
    }
}
