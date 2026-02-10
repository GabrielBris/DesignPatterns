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
        var descExpected: String = ""
        
        patternCatalog = PatternData.poo_pillars
        patternCatalogTitle = localized(patternCatalog.title)
        
        XCTAssertEqual(patternCatalogTitle, "The pillars of the OOP")
        PatternCatalog.POOPillar.allCases.forEach { pillar in
            switch pillar {
            case .abstraction:
                descExpected = "\"Abstraction is the model of a real-world object or phenomenon, limited to a specific context, that represents all the data relevant to this context with great precision, omitting the rest.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: pillar, titleExpected: "Abstraction", descExpected: descExpected))
            case .encapsulation:
                descExpected = "\"Encapsulation is the ability that an object has to hide parts of its state and behavior from other objects, exposing only a limited interface to the rest of the program.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: pillar, titleExpected: "Encapsulation", descExpected: descExpected))
            case .inheritance:
                descExpected = "\"If you want to create a class slightly different from an existing one, there is no need to duplicate the code. Instead, you extend the existing class and place the additional functionality within a resulting subclass that inherits the fields and methods of the superclass.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: pillar, titleExpected: "Inheritance", descExpected: descExpected))
            case .polymorphism:
                descExpected = "\"Polymorphism is the ability that a program has to detect the true class of an object and invoke its implementation, even though its real type is unknown in the current context.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: pillar, titleExpected: "Polymorphism", descExpected: descExpected))
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
