//
//  relations_among_objects.swift
//  DesignPatterns
//
//  Created by Gabriel Alejandro Briseño Alvarez on 09/02/26.
//
import Foundation

enum RelationAmongObjects {
    // Dependency: "Hey, can I borrow this for a sec?" (parameter)
    static func runDependenceExample() {
        let mockTaxDependency = MockTaxDependency(taxText: "+ tax")
        let view = ProductView(name: "Nintendo Switch")
        view.setupTaxView(from: mockTaxDependency)
    }

    // Aggregation: "I have you, but you're not mine forever" (container, items survive independently)
    static func runAgregationExample() {
        let book1 = Book(name: "Salem's Lot", author: "Stehen King")
        let book2 = Book(name: "Frankenstein", author: "Mary Shelley")
        var library: Library? = Library(books: [book1, book2])
        
        print("Before removing our library: ", library?.books.count ?? 0)
        library = nil
        print("After removing it: ", library?.books.count ?? 0)
        print(book1, "\n", book2)
    }

    // Association: "This is my reference, I keep it" (property)
    static func runAssociationExample() {
        let mockTaxDependency = MockTaxDependency(taxText: "+ tax")
        let view = ConcreteView(taxDependency: mockTaxDependency)
        view.showTax()
    }
    
    // Composition: "You're part of me, you live and die with me" (creates and owns, same lifecycle)
    static func runCompositionExample() {
        var homeView: HomeView? = HomeView()
        homeView = nil
        print("HomeView's description: ", homeView.debugDescription)
    }
}


// MARK: - Dependency
private protocol TaxDependency {
    var taxText: String { get }

    func shouldShowTax() -> Bool
}

private struct MockTaxDependency: TaxDependency {
    let taxText: String
    
    func shouldShowTax() -> Bool { true }
}

private struct ProductView {
    let name: String
    
    func setupTaxView(from dependency: TaxDependency) {
        let taxText = dependency.shouldShowTax() ? dependency.taxText : "Free of tax"
        print(name+" "+taxText)
    }
}

// MARK: - Agregation
private struct Book {
    let name: String
    let author: String
}

private struct Library {
    let books: [Book]
    
    func displayBooks() {
        for book in books {
            print("Book: \(book.name), Author: \(book.author)")
        }
    }
}

// MARK: - Association
private struct ConcreteView {
    let taxDependency: TaxDependency

    func showTax() {
        if taxDependency.shouldShowTax() {
            print("Displating tax label: ", taxDependency.taxText)
        }
    }
}

// MARK: - Composition
private protocol HomeViewProtocol {
    var description: String { get }
}

private struct HomeViewModel: HomeViewProtocol {
    var description: String
}

private struct HomeView {
    private let viewModel: HomeViewProtocol = HomeViewModel(description: "This is the home view")
    
    init() {
        print(viewModel.description)
    }
}
