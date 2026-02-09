//
//  PatternCatalogViewModel.swift
//  DesignPatterns
//
//  Created Gabriel Alejandro Briseño Alvarez on 08/02/26.
//  Copyright © 2026 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Gabriel Briseño
//

import Foundation

protocol PatternCatalogViewModelProtocol {
    var titles: [String] { get }
}

@Observable
class PatternCatalogViewModel: PatternCatalogViewModelProtocol {
    private(set) var titles: [String] = []
}
