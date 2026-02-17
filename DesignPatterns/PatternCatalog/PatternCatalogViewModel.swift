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
        PatternData.relation_among_objects,
        PatternData.solid_principles
    ]
    
    func tryMeButtonTapped(at pattern: any PatternItemKeys) {
        switch pattern {
        case let poo_pillars as PatternCatalog.POOPillar:
            switch poo_pillars {
            case .abstraction: OOPPillarTopic.runAbstractionExample()
            case .encapsulation: OOPPillarTopic.runEncapsulationExample()
            case .inheritance: OOPPillarTopic.runInheritanceExample()
            case .polymorphism: OOPPillarTopic.runPolymorphismExample()
            }
        case let relation_among_objects as PatternCatalog.RelationAmongObjects:
            switch relation_among_objects {
            case .dependence: RelationAmongObjects.runDependenceExample()
            case .association: RelationAmongObjects.runAssociationExample()
            case .aggregation: RelationAmongObjects.runAgregationExample()
            case .composition: RelationAmongObjects.runCompositionExample()
            }
        case let solid_principles as PatternCatalog.SOLIDPrinciples:
            switch solid_principles {
            case .single_responsibility: SolidPrinciples.runSingleResponsibilityExample()
            case .open_closed: SolidPrinciples.runOpenClosedExample()
            case .liskov_substitution: SolidPrinciples.runLiskovSubstitutionPrincipleExample()
            case .interface_segregation: SolidPrinciples.runInterfaceSegregationPrincipleExample()
            case .dependency_injection: break
            }
        default: break
        }
    }
}
