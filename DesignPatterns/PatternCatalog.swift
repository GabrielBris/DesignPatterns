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

struct PatternCatalog: Identifiable, Hashable {
    let id = UUID()
    let title: String

    enum POOPillar: String, CaseIterable, PatternItemKeys {
        case abstraction, encapsulation, inheritance, polymorphism

        var titleKey: String { "pillars.\(rawValue).title" }
        var descriptionKey: String { "pillars.\(rawValue).description" }
    }
}
