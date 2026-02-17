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
        
        // POO Pillar
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
        
        // Relation among objects
        patternCatalog = PatternData.relation_among_objects
        patternCatalogTitle = localized(patternCatalog.title)
        
        XCTAssertEqual(patternCatalogTitle, "Relation among objects")
        PatternCatalog.RelationAmongObjects.allCases.forEach { relationType in
            switch relationType {
            case .dependence:
                descExpected = "\"You can make a dependency weaker by making your code depend on interfaces or abstract classes instead of concrete classes.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: relationType, titleExpected: "Dependency", descExpected: descExpected))
            case .association:
                descExpected = "\"Association can be seen as a specialized type of dependency, in which an object always has access to the objects with which it interacts, while simple dependency does not establish a permanent link between objects.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: relationType, titleExpected: "Association", descExpected: descExpected))
            case .aggregation:
                descExpected = "\"Normally, with aggregation, an object 'has' a group of other objects and serves as a container or collection. The component can exist without the container and can be linked to several containers at the same time.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: relationType, titleExpected: "Aggregation", descExpected: descExpected))
            case .composition:
                descExpected = "\"Composition is a specific type of aggregation in which an object is composed of one or more instances of the other. The difference between this and other relationships is that the component can only exist as part of the container.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: relationType, titleExpected: "Composition", descExpected: descExpected))
            }
        }
        
        // SOLID
        patternCatalog = PatternData.solid_principles
        patternCatalogTitle = localized(patternCatalog.title)
        
        XCTAssertEqual(patternCatalogTitle, "SOLID Principles")
        PatternCatalog.SOLIDPrinciples.allCases.forEach { principle in
            switch principle {
            case .single_responsibility:
                descExpected = "\"Try to make each class responsible for a single part of the functionality provided by the software, and make that responsibility completely encapsulated by (you can also say hidden within) the class.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: principle, titleExpected: "Single Re­s­po­n­si­bi­li­ty Pri­n­ci­p­le", descExpected: descExpected))
            case .open_closed:
                descExpected = "\"Classes should be open for extension but closed for modification.\""
                XCTAssertTrue(isPatternItemsMatching(itemKeys: principle, titleExpected: "Open/Closed Principle", descExpected: descExpected))
            case .liskov_substitution:
                descExpected = """
                “When extending a class, remember that you should be able to pass objects of the subclasses in place of objects of the parent class, without breaking the client code.”

                - Basically: If `B` is a subtype of `A`, then you should be able to use an object of `B` anywhere an object of `A` is expected, without breaking the program.

                In other words: a child class should be able to “substitute” the parent class without surprises.
                """
                XCTAssertTrue(isPatternItemsMatching(itemKeys: principle, titleExpected: "Liskov Substitution Principle", descExpected: descExpected))
            case .interface_segregation:
                descExpected = """
                “Clients should not be forced to depend on methods they do not use.  

                According to the **Interface Segregation Principle (ISP)**, you should break down *fat* or *bloated* interfaces into smaller, more granular, and more specific ones. Clients should implement only the methods they actually need. Otherwise, a change to a *fat* interface can cause ripple effects and break even those clients that do not use the modified methods.”
                """
                XCTAssertTrue(isPatternItemsMatching(itemKeys: principle, titleExpected: "Interface Segregation Principle", descExpected: descExpected))
            case .dependency_inversion:
                descExpected = """
                “High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend on details. Details should depend on abstractions.”  

                — Your core business logic (high level) should not *know about* or be tightly coupled to concrete implementation details (low level). Instead, both should communicate through **contracts** (abstractions), which in Swift are typically **protocols**.
                """
                XCTAssertTrue(isPatternItemsMatching(itemKeys: principle, titleExpected: "Dependency Inversion Principle", descExpected: descExpected))
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
