//
//  solid_principles.swift
//  DesignPatterns
//
//  Created by Gabriel Alejandro Briseño Alvarez on 10/02/26.
//
import Foundation

enum SolidPrinciples {
    static func runSingleResponsibilityExample() {
        let gabs = Employee(name: "Gabs", username: "g20b092", daysWorked: 20, salaryPerDay: 10, employeeLevel: 1)
        // print("This month I will get: $ \(gabs.getSalaryPerMonth())")

        print("This month I will get: $ \(gabs.calculateSalaryThismMonth())")
    }
    
    static func runOpenClosedExample() {
        let products = [
            Product(name: "Soda", weight: 0.6, price: 10),
            Product(name: "Soda", weight: 0.6, price: 10)
        ]
        //let order = Order(products: products, shippingType: .ground)
        let order = Order(products: products, shippingType: Car(model: "gt8", type: "Truck"))
        print("Total: \(order.getTotal())")
    }
    
    static func runLiskovSubstitutionPrincipleExample() {
        let range = 0...2
        
        // Read and write documents (Writable)
        var writableDocuments: [WritableTextDocument] = []
        range.forEach { index in
            writableDocuments.append(WritableTextDocument(fileName: "file-\(index).txt"))
        }
        
        let project1 = WritableProject(documents: writableDocuments)
        project1.openAll()
        try? project1.saveAll()
        
        // Read only documents (Non-writable)
        var readOnlyDocuments: [ReadOnlyTextDocument] = []
        range.forEach { index in
            readOnlyDocuments.append(ReadOnlyTextDocument(fileName: "file-\(index).txt"))
        }
        
        let project2 = Project(documents: readOnlyDocuments)
        project2.openAll()
    }

    static func runInterfaceSegregationPrincipleExample() {
        // First example and commented
        /*
         var provider: CloudProviderProtocol
         
         provider = Amazon()
         provider.createServer("CH")
         print(provider.getCDNAddress())
         provider.getFile("configs.py")
         print(provider.listServers("CH"))
         provider.storeFile("configs.py")
         
         provider = Dropbox()
         provider.createServer("CH") // This is not implemented in Dropbox
         let _ = provider.getCDNAddress() // This is not implemented in Dropbox
         provider.getFile("Test_file")
         print(provider.listServers("CH")) // This is not implemented in Dropbox
         provider.storeFile("configs.py")
         */
        
        // Second example
        let amazon = Amazon()
        amazon.createServer("CH")
        print(amazon.getCDNAddress())
        amazon.getFile("configs.py")
        print(amazon.listServers("CH"))
        amazon.storeFile("configs.py")
        
        let dropbox = Dropbox()
        dropbox.getFile("Test_file")
        dropbox.storeFile("configs.py")
    }
    
    static func runDependencyInversionPrincipleExample() {
        //let budgedReport = BudgetReport(database: MySQLDatabase())

        let budgedReport = BudgetReport(database: MongoDB())
        budgedReport.open()
        budgedReport.save()
    }
}

// MARK: - Single Responsibility Principle

// Multiple things that could change in the future, are living at the same entity.
/*
 private struct Employee {
     let name: String
     let username: String
     let daysWorked: Int
     let salaryPerDay: Double
     let employeeLevel: Int
     
     func getSalaryPerMonth() -> Double {
         let commissionPercent: Double
         
         switch employeeLevel {
         case 1: commissionPercent = 1.05
         case 2: commissionPercent = 1.10
         case 3: commissionPercent = 1.15
         default: commissionPercent = 1.0
         }
         
         return (Double(daysWorked) * salaryPerDay * commissionPercent)
     }
 }
 */

// Splitting responsibilities:
final class SalaryCalculator {
    static let shared = SalaryCalculator()
    
    private init() { }
    
    func getSalaryPerMonth(_ employeeLevel: Int, _ daysWorked: Int, _ salaryPerDay: Double) -> Double {
        let commissionPercent: Double
        
        switch employeeLevel {
        case 1: commissionPercent = 1.05
        case 2: commissionPercent = 1.10
        case 3: commissionPercent = 1.15
        default: commissionPercent = 1.0
        }
        
        return (Double(daysWorked) * salaryPerDay * commissionPercent)
    }
}

private struct Employee {
    let name: String
    let username: String
    let daysWorked: Int
    let salaryPerDay: Double
    let employeeLevel: Int
    
    func calculateSalaryThismMonth() -> Double {
        SalaryCalculator.shared.getSalaryPerMonth(employeeLevel, daysWorked, salaryPerDay)
    }
}

// MARK: - Open/Closed Principle
private struct Product {
    let name: String
    let weight: Double
    let price: Double
}

// This gives the possibility to modify directly our Order, and we shouldn't convert as final, because we won't be able to extend it / subclass it.
/*
 private struct Order {
     let products: [Product]
     let shippingType: ShippingType
     
     enum ShippingType {
         case ground
         case air
         case sea
     }
     
     func getTotal() -> Double {
         products.reduce(0) { $0 + $1.price } + getShippingCost()
     }
     
     func getShippingCost() -> Double {
         switch shippingType {
         case .ground: // Free shipping on large orders, else $1.5 per kilo (max $10)
             return products.count > 100 ? 0 : min(10, 1.5 * getTotalWeight())
         case .air:
             return min(30, 3 * getTotalWeight())
         case .sea:
             return min(20, 2 * getTotalWeight())
         }
     }
     
     private func getTotalWeight() -> Double {
         products.reduce(0) { $0 + $1.weight }
     }
 }
 */

private protocol ShippingTypeProtocol {
    func getShippingCost(for products: [Product], totalWeight: Double) -> Double
}

private class Ground: ShippingTypeProtocol {
    fileprivate func getShippingCost(for products: [Product], totalWeight: Double) -> Double {
        products.count > 100 ? 0 : min(10, 1.5 * totalWeight)
    }
}

private class Car: Ground {
    let model: String
    let type: String
    
    init(model: String, type: String) {
        self.model = model
        self.type = type
    }
    
    override func getShippingCost(for products: [Product], totalWeight: Double) -> Double {
        // let's override our super class... maybe next time 😋
        super.getShippingCost(for: products, totalWeight: totalWeight)
    }
}

private class Air: ShippingTypeProtocol {
    fileprivate func getShippingCost(for products: [Product], totalWeight: Double) -> Double {
        min(30, 3 * totalWeight)
    }
}

private struct Order {
    let products: [Product]
    let shippingType: ShippingTypeProtocol

    func getTotal() -> Double {
        products.reduce(0) { $0 + $1.price } + shippingType.getShippingCost(for: products, totalWeight: getTotalWeight())
    }
    
    private func getTotalWeight() -> Double {
        products.reduce(0) { $0 + $1.weight }
    }
}

// MARK: - Liskov Substitution Principle
// In the below commented classes, we are not following Liskov Substitution because we are breaking the original expected behavior from our parent class... So our client will experiment unexpected behaviors.
/*
private protocol DocumentProtocol {
     var data: Data? { get }
     var fileName: String { get }
     
     func open()
     func save()
}
 
 private struct Project<D: DocumentProtocol> {
     var documents = [D]()

     init(documents: [D]) {
         self.documents = documents
     }
     
     func openAll() {
         documents.forEach { document in
             document.open()
         }
     }
     
     func saveAll() {
         documents.forEach { document in
             document.save()
         }
     }
 }
 
private class Document: DocumentProtocol {
     var data: Data?
     var fileName: String
     
     init(data: Data? = nil, fileName: String) {
         self.data = data
         self.fileName = fileName
     }
     
     func open() {
         print("\(fileName) is opened")
     }
     
     func save() {
         print("\(fileName) is saved")
     }
 }

 private class ReadOnlyDocument: Document {
     override func save() {
         print("\(fileName) could not be saved, because it is read-only")
     }
 }
*/

// Our next classes are following Liskov Substitution Principle because we inverted our original approach, converting ReadOnlyDocument as our parent class
private protocol Document {
    func open()
}

private protocol WritableDocument: Document {
    func save() throws
}

private struct Project<D: Document> {
    let documents: [D]

    func openAll() {
        documents.forEach { $0.open() }
    }
}

private struct WritableProject<D: WritableDocument> {
    let documents: [D]

    func saveAll() throws {
        try documents.forEach { try $0.save() }
    }

    func openAll() {
        documents.forEach { $0.open() }
    }
}

private struct ReadOnlyTextDocument: Document {
    let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func open() {
        print("\(fileName) is opened (read-only)")
    }
}

private struct WritableTextDocument: WritableDocument {
    let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func open() {
        print("\(fileName) is opened (writable)")
    }
    
    func save() throws {
        print("\(fileName) is saved")
    }
}

// MARK: - Interface Segregation Principle
// This example forces every cloud provider to implement all methods in CloudProviderProtocol, even when they do not support those capabilities.
 
/*
 private protocol CloudProviderProtocol {
     func createServer(_ region: String)
     func getCDNAddress() -> String
     func getFile(_ name: String)
     func listServers(_ region: String) -> [String]
     func storeFile(_ name: String)
 }

 private struct Amazon: CloudProviderProtocol {
     func createServer(_ region: String) {
         print("Creating server in \(region)")
     }
     
     func getCDNAddress() -> String {
         "This is a test"
     }
     
     func getFile(_ name: String) {
         print("Getting file: \(name)")
     }
     
     func listServers(_ region: String) -> [String] {
         [String](repeating: "", count: 5)
     }
     
     func storeFile(_ name: String) {
         print("Created file: \(name)")
     }
 }

 private struct Dropbox: CloudProviderProtocol {
     // Not necessary
     func createServer(_ region: String) { }
     
     // Not necessary
     func getCDNAddress() -> String { "" }

     func getFile(_ name: String) {
         print("Getting file: \(name)")
     }

     // Not necessary
     func listServers(_ region: String) -> [String] { [String]() }
     
     func storeFile(_ name: String) {
         print("Created file: \(name)")
     }
 }
 */

private protocol CloudHostingProviderProtocol {
    func createServer(_ region: String)
    func listServers(_ region: String) -> [String]
}

private protocol CDNProviderProtocol {
    func getCDNAddress() -> String
}

private protocol CloudStorageProviderProtocol {
    func getFile(_ name: String)
    func storeFile(_ name: String)
}

private struct Amazon: CloudHostingProviderProtocol, CDNProviderProtocol, CloudStorageProviderProtocol {
    func createServer(_ region: String) {
        print("Creating server in \(region)")
    }
    
    func getCDNAddress() -> String {
        "This is a test"
    }
    
    func getFile(_ name: String) {
        print("Getting file: \(name)")
    }
    
    func listServers(_ region: String) -> [String] {
        [String](repeating: "", count: 5)
    }
    
    func storeFile(_ name: String) {
        print("Created file: \(name)")
    }
}

private struct Dropbox: CloudStorageProviderProtocol {
    func getFile(_ name: String) {
        print("Getting file: \(name)")
    }

    func storeFile(_ name: String) {
        print("Created file: \(name)")
    }
}

// MARK: - Dependency Inversion Principle
// First example

// This example violates DIP because the high-level module (BudgetReport)
// depends directly on a low-level implementation detail (MySQLDatabase).
// As a result, changing the database implementation (e.g., MySQL -> SQLite)
// forces changes in BudgetReport. Both should depend on an abstraction (a protocol).

/*
 // Low level
 private struct MySQLDatabase {
     func insert(user: String) {
         print("Inserting user: \(user)")
     }
     
     func update(user: String) {
         print("Updating user: \(user)")
     }
     
     func delete(user: String) {
         print("Deleting user: \(user)")
     }
 }

 // High level
 private struct BudgetReport {
     let database: MySQLDatabase
     
     func open() {
         print("Opened database!")
     }

     func save() {
         print("Saved data!")
     }
 }
 */

// Second example
// Low level
private protocol DataBase {
    func delete(user: String)
    func insert(user: String)
    func update(user: String)
}

private struct MySQLDB: DataBase {
    func delete(user: String) {
        print("Deleting user: \(user)")
    }
    
    func insert(user: String) {
        print("Inserting user: \(user)")
    }

    func update(user: String) {
        print("Updating user: \(user)")
    }
}

private struct MongoDB: DataBase {
    func delete(user: String) {
        print("Deleting user (different): \(user)")
    }
    
    func insert(user: String) {
        print("Inserting user (different): \(user)")
    }

    func update(user: String) {
        print("Updating user (different): \(user)")
    }
}

// High level
private struct BudgetReport {
    private let database: any DataBase
    
    init(database: any DataBase) {
        self.database = database
    }

    func open() {
        print("Opened database!")
    }

    func save() {
        print("Saved data!")
    }
}
