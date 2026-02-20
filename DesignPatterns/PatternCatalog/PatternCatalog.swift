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
    var descriptionKey: String { get }
    var titleKey: String { get }
    var subtopics: [any PatternItemKeys] { get }
    var subtitleKey: String { get }
}

extension PatternItemKeys {
    var descriptionKey: String { "" }
    var subtopics: [any PatternItemKeys] { [] }
    var subtitleKey: String { "" }
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
    
    enum SOLIDPrinciples: String, CaseIterable, PatternItemKeys {
        case single_responsibility, open_closed, liskov_substitution, interface_segregation, dependency_inversion

        var titleKey: String { "solidprinciples.\(rawValue).title" }
        var descriptionKey: String { "solidprinciples.\(rawValue).description" }
    }

    enum DesignPatterns: String, CaseIterable, PatternItemKeys {
        case creational_design_patterns, structural_design_patterns, behavioral_design_patterns
        
        var titleKey: String { "designpatterns.\(rawValue).title" }
        var subtopics: [any PatternItemKeys] { Pattern.allCases }
        
        enum Pattern: String, CaseIterable, PatternItemKeys {
            case factory_method, abstract_factory, builder, prototype, singleton
            
            var titleKey: String { "pattern.\(rawValue).title" }
            var descriptionKey: String {
                switch self {
                default: return "Test"
                }
            }
        }
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
