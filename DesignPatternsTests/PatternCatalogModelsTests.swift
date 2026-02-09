//
//  DesignPatternsTests.swift
//  DesignPatternsTests
//
//  Created by Gabriel Alejandro Briseño Alvarez on 07/02/26.
//

import XCTest
@testable import DesignPatterns

@MainActor
final class PatternCatalogModelsTests: XCTestCase {

    func testCatalogPatternStrings() {
        var patternCatalog: PatternCatalog
        var patternCatalogTitle: String
        
        patternCatalog = PatternData.poo_pillars
        patternCatalogTitle = localized(patternCatalog.title)
        
        XCTAssertEqual(patternCatalogTitle, "Catalog")
        PatternCatalog.POOPillar.allCases.forEach { pillar in
            switch pillar {
            case .abstraction:
                XCTAssertTrue(isPatternItemsMatching(itemKeys: pillar, titleExpected: "Abstraction", descExpected: "o"))
            case .encapsulation:
                XCTAssertTrue(isPatternItemsMatching(itemKeys: pillar, titleExpected: "Encapsulation", descExpected: "o"))
            case .inheritance:
                XCTAssertTrue(isPatternItemsMatching(itemKeys: pillar, titleExpected: "Inheritance", descExpected: "o"))
            case .polymorphism:
                XCTAssertTrue(isPatternItemsMatching(itemKeys: pillar, titleExpected: "Polymorphism", descExpected: "o"))
            }
        }
    }

}

private extension PatternCatalogModelsTests {
    func isPatternItemsMatching(itemKeys: PatternItemKeys, titleExpected: String, descExpected: String) -> Bool {
        let title = localized(itemKeys.titleKey)
        let desc = localized(itemKeys.descriptionKey)

        return title == titleExpected && desc == descExpected
    }
    
    func localized(_ key: String, bundle: Bundle = .main) -> String {
        String(localized: .init(key), bundle: bundle)
    }
}
