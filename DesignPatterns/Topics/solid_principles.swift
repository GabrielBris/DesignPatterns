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
