//
//  PatternCatalog.swift
//  DesignPatterns
//
//  Created Gabriel Alejandro Briseño Alvarez on 08/02/26.
//  Copyright © 2026 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//
import Foundation

protocol PatternItemKeys {
    var titleKey: String { get }
    var descriptionKey: String { get }
}

struct PatternCatalog: Identifiable {
    let id = UUID()
    let title: String
    let topics: [any PatternItemKeys]

    enum POOPillar: String, CaseIterable, PatternItemKeys {
        case abstraction, encapsulation, inheritance, polymorphism

        var titleKey: String { "pillars.\(rawValue).title" }
        var descriptionKey: String { "pillars.\(rawValue).description" }
    }
    
    enum RelationAmongObjects: String, CaseIterable, PatternItemKeys {
        case dependence, aggregation, composition, association
        
        var titleKey: String { "relationamongobjects.\(rawValue).title" }
        var descriptionKey: String { "relationamongobjects.\(rawValue).description" }
    }
}

extension PatternCatalog: Equatable & Hashable {
    static func == (lhs: PatternCatalog, rhs: PatternCatalog) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
