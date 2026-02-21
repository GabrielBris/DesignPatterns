//
//  PatternCatalogViewModel.swift
//  DesignPatterns
//
//  Created Gabriel Alejandro Briseño Alvarez on 08/02/26.
//  Copyright © 2026 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//
import Foundation

enum PatternData {
    static let poo_pillars = PatternCatalog(headerTitle: "pillars.title", topics: PatternCatalog.POOPillar.allCases)
    static let relation_among_objects = PatternCatalog(headerTitle: "relationamongobjects.title", topics: PatternCatalog.RelationAmongObjects.allCases)
    static let solid_principles = PatternCatalog(headerTitle: "solidprinciples.title", topics: PatternCatalog.SOLIDPrinciples.allCases)
    static let design_patterns_catalog = PatternCatalog(headerTitle: "designpatterns.title", topics: PatternCatalog.DesignPatterns.allCases)
}
