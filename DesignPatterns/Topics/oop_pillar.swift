//
//  oop_pillar_topic.swift
//  DesignPatterns
//
//  Created by Gabriel Alejandro Briseño Alvarez on 09/02/26.
//
import Foundation

enum OOPPillarTopic {
    static func runAbstractionExample() {
        let airplane = Airplane(model: "Boeing 747", capacity: 200, color: "White")
        airplane.fly()
    }

    static func runEncapsulationExample() {
        let gabs = Person(name: "Gabriel", birthYear: 1992)
        gabs.printPersonDescription()
        //gabs.calculateAge() -> 'calculateAge' is inaccessible due to 'private' protection level
    }
    
    static func runInheritanceExample() {
        let dog = Dog(´class´: "Animal", numberOfLegs: 4, name: "Max")
        let cat = Cat(´class´: "Animal", numberOfLegs: 4, name: "Tora")
        
        dog.makeSound()
        cat.makeSound()
    }
    
    static func runPolymorphismExample() {
        let animals: [Animal] = [
            Dog(´class´: "Animal", numberOfLegs: 4, name: "Max"),
            Cat(´class´: "Animal", numberOfLegs: 4, name: "Tora"),
            Cat(´class´: "Animal", numberOfLegs: 4, name: "Garfield"),
            Cat(´class´: "Animal", numberOfLegs: 4, name: "Felix"),
            Dog(´class´: "Animal", numberOfLegs: 4, name: "Hachiko")
        ]
        
        animals.forEach { animal in
            animal.makeSound()
            
            switch animal {
            case is Dog: print("Found a Dog")
            case is Cat: print("Found a Cat")
            default: print("This is an unkown Animal")
            }
        }
    }
}

// MARK: - Abstraction
private struct Airplane {
    let model: String
    let capacity: Int
    let color: String
    
    func fly() {
        print("Flying on \(model)")
    }
}

// MARK: - Encapsulation
private protocol PersonProtocol {
    var name: String { get }
    var birthYear: Int { get }
    
    func printPersonDescription()
}

private struct Person: PersonProtocol {
    var name: String
    var birthYear: Int

    func printPersonDescription() {
        print("\(name) is \(calculateAge()) years old.")
    }

    private func calculateAge() -> Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        return currentYear - birthYear
    }
}

// MARK: - Inheritance & Polymorphism
private protocol LivingOrganism {
    var ´class´: String { get }
}

private protocol Animal {
    var numberOfLegs: Int { get }
    var name: String { get }
    
    func makeSound()
}

private struct Dog: LivingOrganism, Animal {
    var ´class´: String
    var numberOfLegs: Int
    var name: String

    func makeSound() {
        print("🐶 roof roof")
    }
}

private struct Cat: LivingOrganism, Animal {
    var ´class´: String
    var numberOfLegs: Int
    var name: String

    func makeSound() {
        print("🐈 miau miau")
    }
}
