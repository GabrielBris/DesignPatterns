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
private struct SalaryCalculator {
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
